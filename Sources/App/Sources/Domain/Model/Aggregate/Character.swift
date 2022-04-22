//
//  Character.swift
//
//
//  Created by Marcelo Silva on 18/4/22
//

public struct Character: Equatable {
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: Thumbnail
    public let comics: [Comic]?

    public init(id: Int, name: String, description: String, thumbnail: Thumbnail, comics: [Comic]? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        self.comics = comics
    }
    
}
