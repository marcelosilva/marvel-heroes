//
//  ComicObjectMother.swift
//  
//
//  Created by Marcelo Silva on 24/4/22.
//

import App

class ComicObjectMother {
    var id = Int.random(in: 1...1000)
    var title = "title"
    var thumbnailUrl = "url"
    
    func withId(id: Int) -> ComicObjectMother {
        self.id = id
        return self
    }
    
    func withTitle(title: String) -> ComicObjectMother {
        self.title = title
        return self
    }
 
    func withThumbnailUrl(thumbnailUrl: String) -> ComicObjectMother {
        self.thumbnailUrl = thumbnailUrl
        return self
    }
    func build() -> Comic {
        Comic(
            id: id,
            title: title,
            thumbnailUrl: thumbnailUrl
        )
    }
}
