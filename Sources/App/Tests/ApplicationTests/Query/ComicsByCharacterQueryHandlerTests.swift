//
//  CharactersQueryHandlerTests.swift
//  
//
//  Created by Marcelo Silva on 18/4/22.
//

import XCTest
@testable import App
import Combine

final class ComicsByCharacterQueryHandlerTests: XCTestCase {

    private let characterService = CharacterServiceMock()
    private var sut: ComicsByCharacterQueryHandler!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        sut = ComicsByCharacterQueryHandler(characterService: characterService)
    }
    
    func testShouldReturnComicsWhenExecutingQuery() {
        // Given
        let mockResponse = [Comic(id: 1, title: "title", thumbnailUrl: "url")]
        characterService.stubbedGetComicsResult = mockResponse
        let characterId = Int.random(in: 1...1000)
        let query = ComicsByCharacterQuery(characterId: characterId)
        let exp = expectation(description: "Get Comics")
        
        
        // When
        let result = sut.doExecute(query: query)
        
        // Then
        XCTAssertEqual(characterService.invokedGetComicsCount, 1)
        XCTAssertEqual(characterService.invokedGetComicsParameters?.characterId, characterId)
                
        result
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Test failed. error")
                case .finished:
                    break
                }
            }, receiveValue: { comics in
                XCTAssertEqual(comics, mockResponse)
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 3)
    }
}


