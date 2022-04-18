//
//  Character.swift
//
//
//  Created by Marcelo Silva on 18/4/22
//

public struct Character: Equatable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    let comics: [Comic]?

    public init(id: Int, name: String, description: String, thumbnail: Thumbnail, comics: [Comic]? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        self.comics = comics
    }
    
}
