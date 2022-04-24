//
//  CharacterDetailViewTests.swift
//  
//
//  Created by Marcelo Silva on 23/4/22.
//

import XCTest
import SnapshotTesting
@testable import Presentation
import SwiftUI
@testable import App

class CharacterDetailViewTests: XCTestCase {
    private var characterDetailViewModel: CharacterDetailViewModel!
    private var characterServiceMock: CharacterServiceMock!
    
    override func setUp() async throws {
        characterServiceMock = CharacterServiceMock()
        characterDetailViewModel = CharacterDetailViewModel(
            queryHandler: ComicsByCharacterQueryHandler(
                characterService: characterServiceMock
            )
        )
    }
    
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
