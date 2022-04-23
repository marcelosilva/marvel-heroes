//
//  MarvelHttpRepositoryMock.swift
//  
//
//  Created by Marcelo Silva on 22/4/22.
//

import Data
import Combine
import Shared

public class MarvelHttpRepositoryMock: MarvelHttpRepositoryProtocol {

    var invokedFindCharacters = false
    var invokedFindCharactersCount = 0
    var invokedFindCharactersParameters: (limit: Int, offset: Int, search: String?, sorting: String?)?
    var invokedFindCharactersParametersList = [(limit: Int, offset: Int, search: String?, sorting: String?)]()
    var stubbedFindCharactersResult: CharactersResponse!
    
    public func findCharacters(
        limit: Int,
        offset: Int,
        search: String?,
        sorting: String?
    ) -> AnyPublisher<CharactersResponse, NetworkError> {
        invokedFindCharacters = true
        invokedFindCharactersCount += 1
        invokedFindCharactersParameters = (limit, offset, search, sorting)
        invokedFindCharactersParametersList.append((limit, offset, search, sorting))
        
        guard let dataStub = stubbedFindCharactersResult else {
            return Fail(error: NetworkError.httpError(409))
                .eraseToAnyPublisher()
        }
        
        return Just(dataStub)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }

    var invokedFindComics = false
    var invokedFindComicsCount = 0
    var invokedFindComicsParameters: (characterId: Int, Void)?
    var invokedFindComicsParametersList = [(characterId: Int, Void)]()
    var stubbedFindComicsResult: ComicsResponse!

    public func findComics(characterId: Int) -> AnyPublisher<ComicsResponse, NetworkError> {
        invokedFindComics = true
        invokedFindComicsCount += 1
        invokedFindComicsParameters = (characterId, ())
        invokedFindComicsParametersList.append((characterId, ()))
        
        guard let dataStub = stubbedFindComicsResult else {
            return Fail(error: NetworkError.httpError(409))
                .eraseToAnyPublisher()
        }
        
        return Just(dataStub)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}
