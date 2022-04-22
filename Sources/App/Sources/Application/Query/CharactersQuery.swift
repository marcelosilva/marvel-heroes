//
//  CharactersQuery.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

public struct CharactersQuery {
    let limit: Int
    let offset: Int
    let textQuery: String?
    let sorting: CharactersQuerySorting
    
    public init(limit: Int, offset: Int, textQuery: String?, sorting: CharactersQuerySorting = .nameAsc) {
        self.limit = limit
        self.offset = offset
        self.textQuery = textQuery
        self.sorting = sorting
    }
}

public enum CharactersQuerySorting {
    case nameAsc
    case nameDesc
    case modifiedAsc
    case modifiedDesc
}
