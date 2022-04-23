//
//  MarvelCharacterRepository.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

import Combine
import Shared

public protocol MarvelCharacterRepositoryProtocol {
    func getCharacters(queryRequest: QueryRequest) -> AnyPublisher<[Character], NetworkError>
    func getComics(characterId: Int) -> AnyPublisher<[Comic], NetworkError>
}

public struct QueryRequest {
    public let limit: Int
    public let offset: Int
    public let search: String?
    public let sorting: String?
    
    public init(limit: Int, offset: Int, search: String?, sorting: String?) {
        self.limit = limit
        self.offset = offset
        self.search = search
        self.sorting = sorting
    }

    
}

