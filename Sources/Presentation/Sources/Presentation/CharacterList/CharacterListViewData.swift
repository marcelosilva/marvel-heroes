//
//  CharacterListViewData.swift
//  MarvelHeroes
//
//  Created by Marcelo Silva on 21/4/22.
//

import Foundation

public struct CharacterListViewData {
    public let sorting: Sorting?
    public let search: String?
    
    public init(sorting: Sorting?, search: String?) {
        self.sorting = sorting
        self.search = search
    }
}

public enum Sorting {
    case nameAsc
    case modifiedAsc
    case nameDesc
    case modifiedDesc
}

public struct CharacterItem: Identifiable, Hashable {
    public let id: Int
    public let characterId: Int
    public let name: String
    public let description: String
    public let thumbnailUrl: String
    public let detailImageUrl: String
    
    public init(id: Int,
                characterId: Int,
                name: String,
                description: String,
                thumbnailUrl: String,
                detailImageUrl: String
    ) {
        self.id = id
        self.characterId = characterId
        self.name = name
        self.description = description
        self.thumbnailUrl = thumbnailUrl
        self.detailImageUrl = detailImageUrl
    }
}
