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
}
