//
//  ContentView.swift
//  MarvelHeroes
//
// Created by Marcelo Silva on 20/4/22.
//

import Combine
import App
import SwiftUI

public enum CharacterListViewState {
    case loading
    case loaded
}

public enum CharacterListViewEvent {
    case search(CharacterListViewData)
    case load(CharacterListViewData)
    case selectItem(CharacterItem)
}

public class CharacterListViewModel: ObservableObject {
    @Published public var state: CharacterListViewState = .loaded
    @Published public var items = [CharacterItem]()
    @Published public var selectedItem: CharacterItem?
    
    private var queryLimit = 20
    private var queryOffSet = 0
    private var cancellables: Set<AnyCancellable> = []
    private let queryHandler: CharactersQueryHandler
    
    public init() {
        queryHandler = CharactersQueryHandler()
    }
    
    public init(queryHandler: CharactersQueryHandler) {
        self.queryHandler = queryHandler
    }

    public func process(event: CharacterListViewEvent) {
        switch event {
        case .load(let contentViewData):
            load(eventData: contentViewData)
        case .search(let contentViewData):
            queryOffSet = 0
            items = []
            load(eventData: contentViewData)
        case .selectItem(let selectedItem):
            self.selectedItem = selectedItem
        }
    }
}

private extension CharacterListViewModel {
    func load(eventData: CharacterListViewData) {
        if state == .loading {
            return
        }
        state = .loading
        queryHandler
            .doExecute(query: buildQuery(eventData: eventData))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.state = .loaded
                    return
                case .failure(_):
                    self.state = .loaded
                    return
                }
                
            }, receiveValue: { characters in
                var index = self.items.count
                characters.forEach { character in
                    self.items.append(
                        CharacterItem(
                            id: index,
                            characterId: character.id,
                            name: character.name,
                            description: character.description,
                            thumbnailUrl: character.thumbnail.url + "/portrait_medium.jpg",
                            detailImageUrl: character.thumbnail.url + "/portrait_uncanny.jpg")
                    )
                    index += 1
                }
                self.queryOffSet += 20
            }).store(in: &cancellables)
        }
    
    func buildQuery(eventData: CharacterListViewData) -> CharactersQuery {
        CharactersQuery(
            limit: queryLimit,
            offset: queryOffSet,
            textQuery: eventData.search,
            sorting: convertSorting(eventData.sorting)
        )
    }
    
    func convertSorting(_ sorting: Sorting?) -> CharactersQuerySorting {
        if let sorting = sorting {
            switch sorting {
            case .nameAsc:
                return .nameAsc
            case .modifiedAsc:
                return .modifiedAsc
            case .nameDesc:
                return .nameDesc
            case .modifiedDesc:
                return .modifiedDesc
            }
        }
        return .nameAsc
    }
}
