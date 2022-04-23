//
// Created by Marcelo Silva on 20/4/22.
//

import Combine
import App
import SwiftUI


enum CharacterListViewState {
    case loading
    case loaded
}

enum CharacterListViewEvent {
    case search(ContentViewData)
    case load(ContentViewData)
    case selectItem(CharacterItem)
}

public class CharacterListViewModel: ObservableObject {
    @Published var state: CharacterListViewState = .loaded
    @Published var items = [CharacterItem]()
    @Published var selectedItem: CharacterItem?
    
    private var queryLimit = 20
    private var queryOffSet = 0
    private var cancellables: Set<AnyCancellable> = []
    private let queryHandler = CharactersQueryHandler(
            characterService: CharacterService(
                    marvelRepository: MarvelCharacterRepositoryAdapter()
            )
    )

    func process(event: CharacterListViewEvent) {
        switch event {
        case .load(let contentViewData):
            loadMore(eventData: contentViewData)
        case .search(let contentViewData):
            queryOffSet = 0
            items = []
            loadMore(eventData: contentViewData)
        case .selectItem(let selectedItem):
            self.selectedItem = selectedItem
        }
    }
}

private extension CharacterListViewModel {
    func loadMore(eventData: ContentViewData) {
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
    
    func buildQuery(eventData: ContentViewData) -> CharactersQuery {
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
