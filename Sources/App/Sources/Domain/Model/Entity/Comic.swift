//
//  Comic.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

public struct Comic: Equatable {
    let id: Int
    let title: String
    let description: String

    public init(id: Int, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
    
}
