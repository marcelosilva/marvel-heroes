//
//  MarvelHttpRepository.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

import Shared
import Combine
import Foundation

public class MarvelNetworkEnvironment: NetworkEnvironmentProtocol {
    public var baseURL = "https://gateway.marvel.com:443/v1/public"
    public var logMode: Bool = false
    public var serverTrust: Bool = true
    public var timeoutInterval = 10.0
    public static let apiKey = "73c4e400a20ba680b43206fc0c239c7e" // to be stored safely
    public static let privateKey = "518eb50b8ce0543dbdbefbb353d35582ea1aded4"

    public static func getSecurityParameters() -> String {
        let ts = abs(UUID().hashValue)
        let hash = "\(ts)\(MarvelNetworkEnvironment.privateKey)\(MarvelNetworkEnvironment.apiKey)".md5() ?? ""
        return "?ts=\(ts)&apikey=\(MarvelNetworkEnvironment.apiKey)&hash=\(hash)"
    }

}

public class MarvelHttpRepository {
    private let networkService: CombineNetworkServiceProtocol

    public init() {
        networkService = CombineNetworkService(environment: MarvelNetworkEnvironment())
    }

    public func findCharacters(limit: Int, offset: Int) -> AnyPublisher<[CharacterEntity], NetworkError> {
        networkService.request(
                with: CharactersEndpoint.getEndpoint(limit: limit, offset: offset)
        ).flatMap { data -> AnyPublisher<[CharacterEntity], NetworkError> in
            Just(data)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        .mapError { networkError in
            networkError
        }
        .eraseToAnyPublisher()
    }
}

public class CharactersEndpoint: NetworkEndpointProtocol {
    public var headers: [String: String]?
    public var path: String = "/characters"
    public var httpMethod = HTTPMethod.get

    static func getEndpoint(limit: Int, offset: Int) -> CharactersEndpoint {
        let endpoint = CharactersEndpoint()
        endpoint.path += "\(MarvelNetworkEnvironment.getSecurityParameters())&limit=\(limit)&offset=\(offset)"
        return endpoint
    }
}