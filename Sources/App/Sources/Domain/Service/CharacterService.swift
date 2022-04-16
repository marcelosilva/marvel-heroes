//
//  CharactersUseCase.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//


class CharacterService {
    
    private let marvelRepository: MarvelCharacterRepository
    
    init(marvelRepository: MarvelCharacterRepository) {
        self.marvelRepository = marvelRepository
    }
    
    func getCharacters(limit: Int, offset: Int) -> [Character] {
        marvelRepository.getCharacters(limit: limit, offset: offset)
    }
}
