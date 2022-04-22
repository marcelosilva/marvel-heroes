//
//  CharactersQueryHandlerTests.swift
//  
//
//  Created by Marcelo Silva on 18/4/22.
//

import XCTest
@testable import App
import Combine

final class CharactersQueryHandlerTests: XCTestCase {

    private let characterService = CharacterServiceMock()
    private var sut: CharactersQueryHandler!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        sut = CharactersQueryHandler(characterService: characterService)
    }
    
    func testShouldReturnCharactersWhenExecutingQuery() {
        // Given
        let mockResponse = [CharacterObjectMother().build()]
        characterService.stubbedGetCharactersResult = mockResponse
        let query = CharactersQuery(limit: 30, offset: 0, textQuery: "textQuery", sorting: .nameAsc)
        let exp = expectation(description: "Get Characters")
        
        // When
        let result = sut.doExecute(query: query)
        
        // Then
        XCTAssertEqual(characterService.invokedGetCharactersCount, 1)
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.limit, 30)
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.offset, 0)
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.sorting, "name")
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.search, "textQuery")
        
        result
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Test failed. error")
                case .finished:
                    break
                }
            }, receiveValue: { characters in
                XCTAssertEqual(characters, mockResponse)
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 3)
    }
    
    func testAvoidHardcodeQueries() {
        // Given
        let mockResponse = [CharacterObjectMother().build()]
        characterService.stubbedGetCharactersResult = mockResponse
        let query = CharactersQuery(limit: 20, offset: 20, textQuery: "nothardcoded", sorting: .modifiedDesc)
        let exp = expectation(description: "Get Characters")
        
        // When
        let result = sut.doExecute(query: query)
        
        // Then
        XCTAssertEqual(characterService.invokedGetCharactersCount, 1)
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.limit, 20)
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.offset, 20)
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.sorting, "-modified")
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.search, "nothardcoded")
        
        result
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Test failed. error")
                case .finished:
                    break
                }
            }, receiveValue: { characters in
                XCTAssertEqual(characters, mockResponse)
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 3)
    }
    
    func testSortingNameDesc() {
        // Given
        let mockResponse = [CharacterObjectMother().build()]
        characterService.stubbedGetCharactersResult = mockResponse
        let query = CharactersQuery(limit: 20, offset: 20, textQuery: "nameDesc", sorting: .nameDesc)
        let exp = expectation(description: "Get Characters")
        
        // When
        let result = sut.doExecute(query: query)
        
        // Then
        XCTAssertEqual(characterService.invokedGetCharactersCount, 1)
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.limit, 20)
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.offset, 20)
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.sorting, "-name")
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.search, "nameDesc")
        
        result
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Test failed. error")
                case .finished:
                    break
                }
            }, receiveValue: { characters in
                XCTAssertEqual(characters, mockResponse)
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 3)
    }
    
    func testSortingModifiedAsc() {
        // Given
        let mockResponse = [CharacterObjectMother().build()]
        characterService.stubbedGetCharactersResult = mockResponse
        let query = CharactersQuery(limit: 20, offset: 20, textQuery: "modifiedAsc", sorting: .modifiedAsc)
        let exp = expectation(description: "Get Characters")
        
        // When
        let result = sut.doExecute(query: query)
        
        // Then
        XCTAssertEqual(characterService.invokedGetCharactersCount, 1)
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.limit, 20)
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.offset, 20)
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.sorting, "modified")
        XCTAssertEqual(characterService.invokedGetCharactersParameters?.search, "modifiedAsc")
        
        result
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Test failed. error")
                case .finished:
                    break
                }
            }, receiveValue: { characters in
                XCTAssertEqual(characters, mockResponse)
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 3)
    }

}


