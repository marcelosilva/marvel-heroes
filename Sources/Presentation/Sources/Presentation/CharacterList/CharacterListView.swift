//
//  ContentView.swift
//  MarvelHeroes
//
//  Created by Marcelo Silva on 15/4/22.
//

import SwiftUI

public struct CharacterListView: View {
    @ObservedObject private var viewModel: CharacterListViewModel
    
    @State var popoverActive = false
    @State private var selectedCharacter: CharacterItem?
    @State private var searchText: String
    @State private var sorting: Sorting
    
    public init(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
        _searchText = State(wrappedValue: "")
        _sorting = State(wrappedValue: .nameAsc)
        self.viewModel.process(event: .load(buildContentData()))
    }
                               
    public var body: some View {
        NavigationView {
            listView
                .navigationTitle(L10n.navigationTitle)
        }
        .popover(isPresented: $popoverActive, content: {
            if let selectedItem = viewModel.selectedItem {
                CharacterDetailView(character: selectedItem)
            }
        })
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                HStack {
                    Picker("Sorting", selection: $sorting) {
                        Text(L10n.characterListViewSortByName)
                            .tag(Sorting.nameAsc)
                        Text(L10n.characterListViewSortByModifiedDesc)
                            .tag(Sorting.modifiedDesc)
                    }
                    .onChange(of: sorting) { _ in
                        viewModel.process(event: .search(buildContentData()))
                    }.disabled(viewModel.state == .loading)
                }
                .pickerStyle(.segmented)
            }
        }
    }
}

private extension CharacterListView {
    var searchTextField: some View {
        TextField(L10n.characterListViewSearchPlaceholder, text: $searchText)
            .submitLabel(.search)
            .onSubmit {
                viewModel.process(event: .search(buildContentData()))
            }
    }
    
    var listView: some View {
        List {
            Section(header: searchTextField) {
                ForEach(viewModel.items, id: \.self) { item in
                    listItemView(item: item)
                }
            }
            if viewModel.state == .loading {
                ProgressView().frame(alignment: .center)
            }
        }
    }
    
    func listItemView(item: CharacterItem) -> some View {
        HStack {
            AsyncImage(url: URL(string: item.thumbnailUrl)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Image(Asset.Images.marvel.name, bundle: Bundle.module)
                    .resizable()
                    .scaledToFit()
            }
            .frame(width:50, height: 75, alignment: .center)
            Text(item.name)
                .onAppear {
                    if item == viewModel.items.last {
                        viewModel.process(event: .load(buildContentData()))
                    }
                }
            Spacer()
        }.contentShape(Rectangle())
            .listRowBackground(Color.randomColorByIndex(index: item.id))
        .onTapGesture {
            viewModel.process(event: .selectItem(item))
            popoverActive.toggle()
        }
    }
  
    func buildContentData() -> CharacterListViewData {
        CharacterListViewData(sorting: sorting, search: searchText)
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(viewModel: CharacterListViewModel())
    }
}
