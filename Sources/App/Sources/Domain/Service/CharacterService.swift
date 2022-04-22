//
//  CharacterService.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//
import Combine

public protocol CharacterServiceProtocol {
    func getCharacters(
        limit: Int,
        offset: Int,
        sorting: String?,
        search: String?
    )-> AnyPublisher<[Character], DomainError>
}

public class CharacterService: CharacterServiceProtocol {
    private let marvelRepository: MarvelCharacterRepositoryProtocol
    
    public init(marvelRepository: MarvelCharacterRepositoryProtocol) {
        self.marvelRepository = marvelRepository
    }
    
    public func getCharacters(
        limit: Int,
        offset: Int,
        sorting: String?,
        search: String?
    ) -> AnyPublisher<[Character], DomainError> {
        marvelRepository.getCharacters(
                            queryRequest: QueryRequest(
                                limit: limit,
                                offset: offset,
                                search: search,
                                sorting: sorting
                            )
            )
            .mapError { networkError in
                DomainError.repositoryConnectionError
            }
            .eraseToAnyPublisher()
    }
}
