//
//  MarvelHttpRepository.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

public class MarvelHttpRepository {
    public init() {
        // to be implemented
    }
    
    public func findCharacters(limit: Int, offset: Int) -> [CharacterEntity] {
        return [CharacterEntity(
            id: 1,
            name: "name",
            description: "description",
            thumbnail: ThumbnailEntity(url: "thumbnail", thumbnailExtension: "jpg")
        )]
    }
}
