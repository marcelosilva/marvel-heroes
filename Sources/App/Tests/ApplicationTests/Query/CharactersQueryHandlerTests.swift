//
//  CharactersQueryHandlerTests.swift
//  
//
//  Created by Marcelo Silva on 18/4/22.
//

import XCTest
@testable import App

final class CharactersQueryHandlerTests: XCTestCase {

    private let characterService = CharacterServiceMock()
    private var sut: CharactersQueryHandler!
    
    override func setUp() {
        sut = CharactersQueryHandler(characterService: characterService)
    }
    
    func testShouldReturnCharactersWhenExecutingQuery() {
        // Given
        let mockResponse = [CharacterObjectMother().build()]
        characterService.stubbedGetCharactersResult = mockResponse
        let query = CharactersQuery(limit: 30, offset: 0)
        
        // When
        let result = sut.doExecute(query: query)
        
        // Then
        XCTAssertEqual(characterService.invokedGetCharactersCount, 1)
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.limit, 30)
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.offset, 0)
        XCTAssertEqual(result, mockResponse)
    }

}


