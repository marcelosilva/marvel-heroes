//
//  MarvelCharacterRepository.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

protocol MarvelCharacterRepository {
    func getCharacters(limit: Int, offset: Int) -> [Character]
}
