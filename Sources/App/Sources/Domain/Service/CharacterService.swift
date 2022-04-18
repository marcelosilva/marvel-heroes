//
//  CharacterService.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

public protocol CharacterServiceProtocol {
    func getCharacters(limit: Int, offset: Int) -> [Character]
}

public class CharacterService {
    
    private let marvelRepository: MarvelCharacterRepository
    
    public init(marvelRepository: MarvelCharacterRepository) {
        self.marvelRepository = marvelRepository
    }
    
    public func getCharacters(limit: Int, offset: Int) -> [Character] {
        marvelRepository.getCharacters(limit: limit, offset: offset)
    }
}
