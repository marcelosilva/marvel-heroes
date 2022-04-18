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
    var thumbnail = Thumbnail(url: "thumbnailUrl", thumbnailExtension: ".jpg")
    var comics: [Comic]? = [Comic(id: 1, title: "title", description: "description")]
    
    func withId(id: Int) {
        self.id = id
    }
    
    func withName(name: String) {
        self.name = name
    }
    
    func withDescription(description: String) {
        self.description = description
    }
    
    func withThumbnail(thumbnail: Thumbnail) {
        self.thumbnail = thumbnail
    }
    
    func withComics(comics: [Comic]) {
        self.comics = comics
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
