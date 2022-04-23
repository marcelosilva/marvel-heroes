//
//  CharacterDetailViewTests.swift
//  
//
//  Created by Marcelo Silva on 23/4/22.
//

import XCTest
import SnapshotTesting
import Presentation
import SwiftUI

class CharacterDetailViewTests: XCTestCase {
    func testDetailView() {
        // Given
        let sut = CharacterDetailView(
            character: CharacterItem(
                id: 10,
                characterId: 10,
                name: "Character Detail View",
                description: "Character Detail View",
                thumbnailUrl: "",
                detailImageUrl: ""
            )
        )
        
        // When
        let view = UIHostingController(rootView: sut)
        
        // Then
        assertSnapshot(matching: view, as: .image(size: CGSize(width: 768, height: 1024)))
    }
}
