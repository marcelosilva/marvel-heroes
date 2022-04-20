//
//  CombineNetworkService.swift
//
//
//  Created by Marcelo Silva on 20/04/22.
//

import Combine
import Foundation

public final class CombineNetworkService: NSObject, CombineNetworkServiceProtocol, NetworkServiceBaseProtocol {
    let environment: NetworkEnvironmentProtocol
    private lazy var session: URLSession = .init(configuration: .default, delegate: self, delegateQueue: nil)

    public init(environment: NetworkEnvironmentProtocol) {
        self.environment = environment
        super.init()
    }

    public func request<T: Decodable>(with endpoint: NetworkEndpointProtocol) -> AnyPublisher<T, NetworkError> {
        guard let session = initializeSession(with: endpoint) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        return session
            .mapError { error -> NetworkError in
                .unknown
            }
            .flatMap { data, response -> AnyPublisher<T, NetworkError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: NetworkError.unknown)
                        .eraseToAnyPublisher()
                }

                if (200 ... 299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: T.self, decoder: JSONDecoder())
                        .mapError { _ in .decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkError.httpError(response.statusCode))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - URLSessionDelegate

extension CombineNetworkService: URLSessionDelegate {
    public func urlSession(
        _: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        let serverTrust = environment.serverTrust
        let disposition: URLSession.AuthChallengeDisposition = serverTrust ? .performDefaultHandling : .useCredential
        if let challengeServerTrust = challenge.protectionSpace.serverTrust {
            completionHandler(disposition, URLCredential(trust: challengeServerTrust))
        } else {
            completionHandler(disposition, nil)
        }
    }
}

// MARK: -

private extension CombineNetworkService {
    func initializeSession(
        with endpoint: NetworkEndpointProtocol
    ) -> Publishers.ReceiveOn<URLSession.DataTaskPublisher, DispatchQueue>? {
        guard let urlRequest = urlRequest(endpoint: endpoint) else { return nil }
        return session
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.global(qos: .background))
    }
}
