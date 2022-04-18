//
//  MarvelCharacterRepositoryAdapter.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

import Data

class MarvelCharacterRepositoryAdapter: MarvelCharacterRepository {
    private let marvelHttpRepository: MarvelHttpRepository
    
    init (marvelHttpRepository: MarvelHttpRepository) {
        self.marvelHttpRepository = marvelHttpRepository
    }
    
    func getCharacters(limit: Int, offset: Int) -> [Character] {
        let characters = marvelHttpRepository.findCharacters(limit: limit, offset: offset)
        return characters.compactMap { entity in
            convert(characterEntity: entity)
        }
    }
}

private extension MarvelCharacterRepositoryAdapter {
    
    func convert(characterEntity: CharacterEntity) -> Character {
        return Character(
            id: characterEntity.id,
            name: characterEntity.name,
            description: characterEntity.description,
            thumbnail: Thumbnail(
                url: characterEntity.thumbnail.url,
                thumbnailExtension: characterEntity.thumbnail.thumbnailExtension
            )
        )
    }
}
