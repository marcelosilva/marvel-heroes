//
//  CharactersQueryHandler.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

import Combine

public class CharactersQueryHandler {
    private let characterService: CharacterServiceProtocol
    
    public init(characterService: CharacterServiceProtocol) {
        self.characterService = characterService
    }
    
    public func doExecute(query: CharactersQuery) -> AnyPublisher<[Character], DomainError> {
        characterService.getCharacters(limit: query.limit, offset: query.offset)
    }
    
}
