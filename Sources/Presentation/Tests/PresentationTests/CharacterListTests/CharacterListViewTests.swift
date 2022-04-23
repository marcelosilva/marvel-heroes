//
//  CharacterListViewTests.swift
//  
//
//  Created by Marcelo Silva on 23/4/22.
//

import XCTest
import SnapshotTesting
import Presentation
@testable import App
import SwiftUI

class CharacterListViewTests: XCTestCase {
    private var characterListViewModel: CharacterListViewModel!
    private var characterServiceMock: CharacterServiceMock!
    
    override func setUp() {
        super.setUp()
        characterServiceMock = CharacterServiceMock()
        characterListViewModel = CharacterListViewModel(
            queryHandler: CharactersQueryHandler(
                characterService: characterServiceMock
            )
        )
    }
    
    func testLoading() {
        // Given
        let sut = CharacterListView(viewModel: characterListViewModel)
        
        // When
        let view = UIHostingController(rootView: sut)
        
        // Then
        assertSnapshot(matching: view, as: .image(size: CGSize(width: 768, height: 1024)))
    }
    
    func testListLoaded() {
        // Given
        var mockResponse = [Character]()
        for i in 1...20 {
            mockResponse.append(CharacterObjectMother()
                .withId(id: i)
                .withName(name: "Character \(i)")
                .build())
        }
        
        characterServiceMock.stubbedGetCharactersResult = mockResponse
        
        let exp = expectation(description: "List Characters")
        exp.isInverted = true
        let sut = CharacterListView(viewModel: characterListViewModel)
        
        // When
        characterListViewModel.process(event: .search(CharacterListViewData(sorting: .nameAsc, search: "")))
        let view = UIHostingController(rootView: sut)
        
        // Then
        waitForExpectations(timeout: 1)
        assertSnapshot(matching: view, as: .image(size: CGSize(width: 768, height: 1024)))
    }
    
}
