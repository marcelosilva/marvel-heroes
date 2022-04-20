//
//  ContentView.swift
//  MarvelHeroes
//
//  Created by Marcelo Silva on 15/4/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel: ContentViewModel

    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
        self.viewModel.process(event: .process)
    }
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loaded:
                Text("LOADED").padding()
            case .loading:
                Text("LOADING").padding()
            case .error:
                Text("ERROR").padding()
            }
            Button("Test") {
                viewModel.process(event: .process)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
