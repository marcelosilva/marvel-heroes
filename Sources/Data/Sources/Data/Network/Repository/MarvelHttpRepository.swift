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
    public static let apiKey = "9dd70f4035c407fa55e899cd6036e746" // to be stored safely
    public static let privateKey = "bbba345a2422db304d9c6725edab5b132527a4b5" // to be stored safely

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
    
    func findComics(characterId: Int) -> AnyPublisher<ComicsResponse, NetworkError>
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
    
    public func findComics(characterId: Int) -> AnyPublisher<ComicsResponse, NetworkError> {
        networkService.request(
            with: ComicsByCharacterEndpoint.getEndpoint(characterId: characterId)
        ).flatMap { data -> AnyPublisher<ComicsResponse, NetworkError> in
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
