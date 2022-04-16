//
//  MarvelCharacterRepositoryAdapter.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

import Data

class MarvelCharacterRepositoryAdapter: MarvelCharacterRepository {
    private let marvelHttpRepository = MarvelHttpRepository()
    
    func getCharacters(limit: Int, offset: Int) -> [Character] {
        return [Character(
            id: 1,
            name: "name",
            description: "description",
            thumbnail: "thumbnail"
        )]
    }
    
    
}
