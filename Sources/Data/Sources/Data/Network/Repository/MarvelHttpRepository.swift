//
//  MarvelHttpRepository.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

import Shared
import Combine
import Foundation

class MarvelNetworkEnvironment: NetworkEnvironmentProtocol {
    public var baseURL = "https://gateway.marvel.com:443/v1/public"
    public var logMode: Bool = false
    public var serverTrust: Bool = true
    public var timeoutInterval = 10.0
    public static let apiKey = "73c4e400a20ba680b43206fc0c239c7e" // to be stored safely
    public static let privateKey = "518eb50b8ce0543dbdbefbb353d35582ea1aded4" // to be stored safely

    public static func getSecurityParameters() -> String {
        let ts = abs(UUID().hashValue)
        let hash = "\(ts)\(MarvelNetworkEnvironment.privateKey)\(MarvelNetworkEnvironment.apiKey)".md5() ?? ""
        return "?ts=\(ts)&apikey=\(MarvelNetworkEnvironment.apiKey)&hash=\(hash)"
    }
}

public protocol MarvelHttpRepositoryProtocol {
    func findCharacters(
        limit: Int,
        offset: Int,
        search: String?,
        sorting: String?
    ) -> AnyPublisher<CharactersResponse, NetworkError>
}

public class MarvelHttpRepository: MarvelHttpRepositoryProtocol {
    private let networkService: CombineNetworkServiceProtocol

    public init(networkService: CombineNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    public init() {
        networkService = CombineNetworkService(environment: MarvelNetworkEnvironment())
    }

    public func findCharacters(
        limit: Int,
        offset: Int,
        search: String?,
        sorting: String?
    ) -> AnyPublisher<CharactersResponse, NetworkError> {
        networkService.request(
            with: CharactersEndpoint.getEndpoint(limit: limit, offset: offset, search: search, sorting: sorting)
        ).flatMap { data -> AnyPublisher<CharactersResponse, NetworkError> in
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

public class CharactersEndpoint: NetworkEndpointProtocol, Equatable {
    
    public var headers: [String: String]?
    public var path: String = "/characters"
    public var httpMethod = HTTPMethod.get

    public static func getEndpoint(
        limit: Int,
        offset: Int,
        search: String?,
        sorting: String?
    ) -> CharactersEndpoint {
        let endpoint = CharactersEndpoint()
        endpoint.path += "\(MarvelNetworkEnvironment.getSecurityParameters())&limit=\(limit)&offset=\(offset)"
       
        if let search = search, search.count > 0 {
            let encodedSearch = search
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? search
            endpoint.path += "&nameStartsWith=\(encodedSearch)"
        }
        
        if let sorting = sorting {
            endpoint.path += "&orderBy=\(sorting)"
        }
        return endpoint
    }
    
    public static func == (lhs: CharactersEndpoint, rhs: CharactersEndpoint) -> Bool {
        return lhs.path == rhs.path && lhs.httpMethod == rhs.httpMethod
    }
    
}
