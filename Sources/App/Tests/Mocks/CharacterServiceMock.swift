//
//  CharacterServiceMock.swift
//  
//
//  Created by Marcelo Silva on 18/4/22.
//

import App

public class CharacterServiceMock: CharacterServiceProtocol {

    var invokedGetCharacters = false
    var invokedGetCharactersCount = 0
    var invokedGetCharactersParameters: (limit: Int, offset: Int)?
    var invokedGetCharactersParametersList = [(limit: Int, offset: Int)]()
    var stubbedGetCharactersResult: [Character]! = []

    public func getCharacters(limit: Int, offset: Int) -> [Character] {
        invokedGetCharacters = true
        invokedGetCharactersCount += 1
        invokedGetCharactersParameters = (limit, offset)
        invokedGetCharactersParametersList.append((limit, offset))
        return stubbedGetCharactersResult
    }
}
