//
//  CharactersQueryHandler.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

import Combine

public class CharactersQueryHandler {
    private let characterService: CharacterServiceProtocol
    
    public init() {
        characterService = CharacterService(marvelRepository: MarvelCharacterRepositoryAdapter())
    }
    
    init(characterService: CharacterServiceProtocol) {
        self.characterService = characterService
    }
    
    public func doExecute(query: CharactersQuery) -> AnyPublisher<[Character], DomainError> {
        characterService.getCharacters(
            limit: query.limit,
            offset: query.offset,
            sorting: translateSorting(query.sorting),
            search: query.textQuery
        )
    }
}

private extension CharactersQueryHandler {
    func translateSorting(_ sorting: CharactersQuerySorting) -> String {
        switch sorting {
        case .nameAsc:
            return "name"
        case .nameDesc:
            return "-name"
        case .modifiedAsc:
            return "modified"
        case .modifiedDesc:
            return "-modified"
        }
    }
}
