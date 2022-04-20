//
//  Thumbnail.swift
//  
//
//  Created by Marcelo Silva on 18/4/22.
//

public struct Thumbnail: Equatable {
    let url: String?
    let thumbnailExtension: String?
    
    public init(url: String?, thumbnailExtension: String?) {
        self.url = url
        self.thumbnailExtension = thumbnailExtension
    }
}
