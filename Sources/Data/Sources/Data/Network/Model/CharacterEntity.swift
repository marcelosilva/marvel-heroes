//
//  CharacterEntity.swift
//  
//
//  Created by Marcelo Silva on 18/4/22.
//

public struct CharacterEntity {
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: ThumbnailEntity
    public let comics: [ComicEntity]? = nil
}

public struct ThumbnailEntity {
    public let url: String
    public let thumbnailExtension: String
}

public struct ComicEntity {
    public let id: Int
    public let title: String
    public let description: String
}
