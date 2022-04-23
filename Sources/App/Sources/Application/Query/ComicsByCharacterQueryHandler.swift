//
//  CharactersQueryHandler.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

import Combine

public class ComicsByCharacterQueryHandler {
    private let characterService: CharacterServiceProtocol
    
    public init() {
        characterService = CharacterService(marvelRepository: MarvelCharacterRepositoryAdapter())
    }
    
    init(characterService: CharacterServiceProtocol) {
        self.characterService = characterService
    }
    
    public func doExecute(query: ComicsByCharacterQuery) -> AnyPublisher<[Comic], DomainError> {
        characterService.getComics(characterId: query.characterId)
    }
}
