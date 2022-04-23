//
//  CharacterService.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//
import Combine
import Foundation

protocol CharacterServiceProtocol {
    func getCharacters(
        limit: Int,
        offset: Int,
        sorting: String?,
        search: String?
    )-> AnyPublisher<[Character], DomainError>
    
    func getComics(characterId: Int) -> AnyPublisher<[Comic], DomainError>
}

class CharacterService: CharacterServiceProtocol {
    private let marvelRepository: MarvelCharacterRepositoryProtocol
    
    init(marvelRepository: MarvelCharacterRepositoryProtocol) {
        self.marvelRepository = marvelRepository
    }
    
    func getCharacters(
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
    
    public func getComics(characterId: Int) -> AnyPublisher<[Comic], DomainError> {
        marvelRepository.getComics(characterId: characterId)
        .mapError { networkError in
            DomainError.repositoryConnectionError
        }
        .eraseToAnyPublisher()
    }
}
