//
//  ContentViewData.swift
//  
//
//  Created by Marcelo Silva on 21/4/22.
//

import Foundation

struct ContentViewData {
    let sorting: Sorting?
    let search: String?
}

enum Sorting {
    case nameAsc
    case modifiedAsc
    case nameDesc
    case modifiedDesc
}

struct CharacterItem: Identifiable, Hashable {
    let id: Int
    let characterId: Int
    let name: String
    let description: String
    let thumbnailUrl: String
    let detailImageUrl: String
}
