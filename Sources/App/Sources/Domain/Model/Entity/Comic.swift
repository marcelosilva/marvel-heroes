//
//  Comic.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

import Foundation

public struct Comic: Equatable {
    public let id: Int
    public let title: String
    public let thumbnailUrl: String

    public init(id: Int, title: String, thumbnailUrl: String) {
        self.id = id
        self.title = title
        self.thumbnailUrl = thumbnailUrl
    }
    
}
