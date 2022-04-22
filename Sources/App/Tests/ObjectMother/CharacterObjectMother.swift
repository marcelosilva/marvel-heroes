//
//  CharacterObjectMother.swift
//  
//
//  Created by Marcelo Silva on 18/4/22.
//

import App

class CharacterObjectMother {
    var id = Int.random(in: 1...1000)
    var name = "CharacterName"
    var description = "CharacterDescription"
    var thumbnail = Thumbnail(url: "thumbnailUrl")
    var comics: [Comic]? = [Comic(id: 1, title: "title", description: "description")]
    
    func withId(id: Int) -> CharacterObjectMother {
        self.id = id
        return self
    }
    
    func withName(name: String) -> CharacterObjectMother {
        self.name = name
        return self
    }
    
    func withDescription(description: String) -> CharacterObjectMother {
        self.description = description
        return self
    }
    
    func withThumbnail(thumbnail: Thumbnail) -> CharacterObjectMother {
        self.thumbnail = thumbnail
        return self
    }
    
    func withComics(comics: [Comic]?) -> CharacterObjectMother {
        self.comics = comics
        return self
    }
    
    func build() -> Character {
        Character(
            id: id,
            name: name,
            description: description,
            thumbnail: thumbnail,
            comics: comics
        )
    }
    
}
