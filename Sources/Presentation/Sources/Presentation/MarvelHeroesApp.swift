//
//  MarvelHeroesApp.swift
//  MarvelHeroes
//
//  Created by Marcelo Silva on 15/4/22.
//

import SwiftUI

@main
struct MarvelHeroesApp: App {
    var body: some Scene {
        WindowGroup {
            CharacterListView(viewModel: CharacterListViewModel())
        }
    }
}
