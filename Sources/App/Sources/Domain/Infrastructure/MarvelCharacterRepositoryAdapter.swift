//
//  MarvelCharacterRepositoryAdapter.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

import Data
import Shared
import Combine

class MarvelCharacterRepositoryAdapter: MarvelCharacterRepositoryProtocol {
    private let marvelHttpRepository: MarvelHttpRepositoryProtocol

    init(marvelHttpRepository: MarvelHttpRepositoryProtocol) {
        self.marvelHttpRepository = marvelHttpRepository
    }

    init() {
        marvelHttpRepository = MarvelHttpRepository()
    }

    public func getCharacters(queryRequest: QueryRequest) -> AnyPublisher<[Character], NetworkError> {
        marvelHttpRepository
                .findCharacters(
                        limit: queryRequest.limit,
                        offset: queryRequest.offset,
                        search: queryRequest.search,
                        sorting: queryRequest.sorting
                )
                .flatMap { [weak self] data -> AnyPublisher<[Character], NetworkError> in
                    Just(data.data.results.compactMap { entity in
                        self?.convert(characterEntity: entity)
                    })
                            .setFailureType(to: NetworkError.self)
                            .eraseToAnyPublisher()
                }
                .mapError { networkError in
                    networkError
                }
                .eraseToAnyPublisher()
    }

    public func getComics(characterId: Int) -> AnyPublisher<[Comic], NetworkError> {
        marvelHttpRepository
            .findComics(characterId: characterId)
            .flatMap { [weak self] data -> AnyPublisher<[Comic], NetworkError> in
                Just(data.data.results.compactMap { entity in
                    self?.convert(comicEntity: entity)
                })
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
            }
            .mapError { networkError in
                networkError
            }
            .eraseToAnyPublisher()
    }
}

private extension MarvelCharacterRepositoryAdapter {
    
    func convert(characterEntity: CharacterEntity) -> Character {
        Character(
            id: characterEntity.id,
            name: characterEntity.name,
            description: characterEntity.description,
            thumbnail: Thumbnail(
                url: characterEntity.thumbnail.path
            )
        )
    }
    
    func convert(comicEntity: ComicsEntity) -> Comic {
        Comic(
            id: comicEntity.id,
            title: comicEntity.title,
            thumbnailUrl: comicEntity.thumbnail.path
        )
    }
}
