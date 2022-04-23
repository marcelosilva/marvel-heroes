//
//  CharacterDetailViewModel.swift
//  
//
//  Created by Marcelo Silva on 23/4/22.
//

import Foundation

import Combine
import App
import SwiftUI

public enum CharacterDetailViewState {
    case loading
    case loaded
}

public enum CharacterDetailViewEvent {
    case loadComics(CharacterDetailViewData)
}

public class CharacterDetailViewModel: ObservableObject {
    @Published public var state: CharacterDetailViewState = .loaded
    @Published public var items = [ComicItem]()
    
    private var cancellables: Set<AnyCancellable> = []
    private let queryHandler: ComicsByCharacterQueryHandler
    
    public init() {
        queryHandler = ComicsByCharacterQueryHandler()
    }
    
    public init(queryHandler: ComicsByCharacterQueryHandler) {
        self.queryHandler = queryHandler
    }
    
    public func process(event: CharacterDetailViewEvent) {
        switch event {
        case .loadComics(let data):
            load(eventData: data)
        }
    }
}

private extension CharacterDetailViewModel {
    func load(eventData: CharacterDetailViewData) {
        if state == .loading {
            return
        }
        state = .loading
        queryHandler
            .doExecute(query: ComicsByCharacterQuery(characterId: eventData.characterId))
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
                
            }, receiveValue: { comics in
                self.items = comics.compactMap({ element in
                    ComicItem(
                        id: element.id,
                        title: element.title,
                        thumbnailUrl: element.thumbnailUrl + "/portrait_medium.jpg"
                    )
                })
                
            }).store(in: &cancellables)
    }
}
