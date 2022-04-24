//
//  CharacterDetailView.swift
//  
//
//  Created by Marcelo Silva on 22/4/22.
//

import SwiftUI

public struct CharacterDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var showComics = false
    
    private let character: CharacterItem
    private let viewModel: CharacterDetailViewModel
    
    public init(character: CharacterItem) {
        self.character = character
        viewModel = CharacterDetailViewModel()
        viewModel.process(
            event: .loadComics(
                CharacterDetailViewData(
                    characterId: character.characterId
                )
            )
        )
    }
    
    public init(character: CharacterItem, viewModel: CharacterDetailViewModel) {
        self.character = character
        self.viewModel = viewModel
        self.viewModel.process(
            event: .loadComics(
                CharacterDetailViewData(
                    characterId: character.characterId
                )
            )
        )
    }
    
    public var body: some View {
        VStack(alignment: .trailing) {
            detailScroll
            if showComics {
                comicsScroll
            }
        }.background(Color.randomColorByIndex(index: character.id))
    }
    
    func toggleShowComics() {
        showComics.toggle()
    }
}


private extension CharacterDetailView {
    var detailScroll: some View {
        ScrollView(showsIndicators: false) {
            ZStack(alignment: .topTrailing) {
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
                    .background(Color.marvelRed)
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
                        .background(Color.marvelRed)
                        .cornerRadius(4)
                        .padding(.horizontal)
                    }
                }
                HStack {
                    Image(systemName: "book.circle.fill")
                        .resizable()
                        .foregroundColor(Color.marvelRed)
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 10)
                        .onTapGesture {
                            withAnimation {
                                showComics.toggle()
                            }
                        }
                    
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(Color.marvelRed)
                        .frame(width: 20, height: 20)
                        .padding(5)
                        .padding(.trailing, 10)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                .padding(.top, 10)
                .padding(.trailing, 10)
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
    
    @ViewBuilder
    var comicsScroll: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .loaded:
            ZStack(alignment: .topLeading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.items, id: \.self) { item in
                            LazyVStack {
                                AsyncImage(url: URL(string: item.thumbnailUrl)) { image in
                                    image.resizable().scaledToFit()
                                } placeholder: {
                                    Image(Asset.Images.marvel.name, bundle: Bundle.module)
                                        .resizable()
                                        .scaledToFit()
                                }.frame(width: 100, height: 120, alignment: .center)
                                Text(item.title)
                                    .font(Font.system(size: 10, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                                    .frame(width: 90, height: 40, alignment: .center)
                                    .padding(.horizontal)
                            }
                        }.padding(.top, 5)
                    }
                }.padding(.top, 25)
                Text(L10n.characterDetailViewComics)
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
                    .padding(.top, 5)
                    .background(Color.marvelRed)
            }.transition(.scale)
            .background(Color.marvelRed)
        }
    }
}
