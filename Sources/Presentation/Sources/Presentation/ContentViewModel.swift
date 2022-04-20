//
// Created by Marcelo Silva on 20/4/22.
//

enum ContentViewState {
    case loading
    case loaded
    case error
}

enum ContentViewEvent {
    case process
}

import Combine
import App
import SwiftUI

public class ContentViewModel: ObservableObject {
    @State var state: ContentViewState = .loading
    private var cancellables: Set<AnyCancellable> = []
    private let queryHandler = CharactersQueryHandler(
            characterService: CharacterService(
                    marvelRepository: MarvelCharacterRepositoryAdapter()
            )
    )

    func process(event: ContentViewEvent) {
        state = .loading
        queryHandler
            .doExecute(query: CharactersQuery(limit: 10, offset: 0))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                self.state = .error
            }, receiveValue: { characters in
                self.state = .loaded
            }).store(in: &cancellables)

    }

}