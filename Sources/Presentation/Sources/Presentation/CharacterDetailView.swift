//
//  CharacterDetailView.swift
//  
//
//  Created by Marcelo Silva on 22/4/22.
//

import SwiftUI

struct CharacterDetailView: View {
    
    private let character: CharacterItem
    
    init(character: CharacterItem) {
        self.character = character
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("MarvelColor\(character.id % 4)")
            VStack {
                ZStack {
                    Color.black
                    AsyncImage(url: URL(string: character.detailImageUrl)) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 200, alignment: .center)
                }.frame(height: 200)
                
                HStack {
                    Text(character.name)
                        .padding()
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    alignment: .center
                )
                .background(Color.marvel4)
                .cornerRadius(4)
                .padding(.horizontal)
                
                if !character.description.isEmpty {
                    HStack {
                        Text(character.description)
                            .padding()
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        alignment: .topLeading
                    )
                    .background(Color.marvel4)
                    .cornerRadius(4)
                    .padding(.horizontal)
                }
            }
        }
    }
}
