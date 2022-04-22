//
//  ContentView.swift
//  MarvelHeroes
//
//  Created by Marcelo Silva on 15/4/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel: ContentViewModel
    
    @State var popoverActive = false
    @State private var selectedCharacter: CharacterItem?
    @State private var searchText: String
    @State private var sorting: Sorting
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
        _searchText = State(wrappedValue: "")
        _sorting = State(wrappedValue: .nameAsc)
        self.viewModel.process(event: .load(buildContentData()))
    }
                               
    var body: some View {
        NavigationView {
            listView
            .navigationTitle("Marvel Heroes")
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
                        Text("By Name")
                            .tag(Sorting.nameAsc)
                        Text("By Last modified")
                            .tag(Sorting.modifiedDesc)
                    }
                    .onChange(of: sorting) { sorting in
                        viewModel.process(event: .search(buildContentData()))
                    }.disabled(viewModel.state == .loading)
                }
                .pickerStyle(.segmented)
            }
        }
    }
}

private extension ContentView {
    
    var searchTextField: some View {
        TextField("Search", text: $searchText)
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
    
    @ViewBuilder
    func listItemView(item: CharacterItem) -> some View {
        HStack {
            AsyncImage(url: URL(string: item.thumbnailUrl)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Image("Marvel")
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
        .listRowBackground(Color("MarvelColor\(item.id % 4)"))
        .onTapGesture {
            viewModel.process(event: .selectItem(item))
            popoverActive.toggle()
        }
    }
  
    func buildContentData() -> ContentViewData {
        ContentViewData(sorting: sorting, search: searchText)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
