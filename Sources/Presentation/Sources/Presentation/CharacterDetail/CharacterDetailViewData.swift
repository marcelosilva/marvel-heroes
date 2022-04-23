//
//  CharacterDetailViewData.swift
//  
//
//  Created by Marcelo Silva on 23/4/22.
//

public struct CharacterDetailViewData {
    public let characterId: Int
    
    public init(characterId: Int) {
        self.characterId = characterId
    }
}

public struct ComicItem: Hashable {
    public let id: Int
    public let title: String
    public let thumbnailUrl: String
}
