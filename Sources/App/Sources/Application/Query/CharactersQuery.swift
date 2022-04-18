//
//  CharactersQuery.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

public struct CharactersQuery {
    let limit: Int
    let offset: Int
    
    public init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }
}
