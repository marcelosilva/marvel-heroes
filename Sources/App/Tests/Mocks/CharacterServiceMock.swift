//
//  CharacterServiceMock.swift
//  
//
//  Created by Marcelo Silva on 18/4/22.
//

import App
import Combine

public class CharacterServiceMock: CharacterServiceProtocol {
    var invokedGetCharacters = false
    var invokedGetCharactersCount = 0
    var invokedGetCharactersParameters: (limit: Int, offset: Int, sorting: String?, search: String?)?
    var invokedGetCharactersParametersList = [(limit: Int, offset: Int)]()
    var stubbedGetCharactersResult: [Character]!

    public func getCharacters(
        limit: Int,
        offset: Int,
        sorting: String?,
        search: String?
    ) -> AnyPublisher<[Character], DomainError> {
        invokedGetCharacters = true
        invokedGetCharactersCount += 1
        invokedGetCharactersParameters = (limit, offset, sorting, search)
        invokedGetCharactersParametersList.append((limit, offset))
        
        guard let dataStub = stubbedGetCharactersResult else {
            return Fail(error: DomainError.repositoryConnectionError)
                .eraseToAnyPublisher()
        }
        
        return Just(dataStub)
            .setFailureType(to: DomainError.self)
            .eraseToAnyPublisher()
    }
}
