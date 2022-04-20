//
//  MarvelCharacterRepositoryAdapter.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

import Data
import Shared
import Combine

public class MarvelCharacterRepositoryAdapter: MarvelCharacterRepositoryProtocol {
    private let marvelHttpRepository: MarvelHttpRepository

    public init(marvelHttpRepository: MarvelHttpRepository) {
        self.marvelHttpRepository = marvelHttpRepository
    }

    public init() {
        marvelHttpRepository = MarvelHttpRepository()
    }

    public func getCharacters(limit: Int, offset: Int) -> AnyPublisher<[Character], NetworkError> {
        marvelHttpRepository.findCharacters(limit: limit, offset: offset)
        .flatMap { [weak self] data -> AnyPublisher<[Character], NetworkError> in
            Just(data.compactMap { entity in
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
}

private extension MarvelCharacterRepositoryAdapter {
    
    func convert(characterEntity: CharacterEntity) -> Character {
        return Character(
            id: characterEntity.id,
            name: characterEntity.name,
            description: characterEntity.description,
            thumbnail: Thumbnail(
                url: characterEntity.thumbnail?.url,
                thumbnailExtension: characterEntity.thumbnail?.thumbnailExtension
            )
        )
    }
}
