//
//  CharactersQueryHandler.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//


public class CharactersQueryHandler {
    
    private let characterService = CharacterService(
        marvelRepository: MarvelCharacterRepositoryAdapter()
    )
    
    public func doExecute(query: CharactersQuery) -> [Character] {
        characterService.getCharacters(limit: query.limit, offset: query.offset)
    }
    
}
