//
//  MarvelHttpRepositoryTests.swift
//
//
//  Created by Marcelo Silva on 22/4/22.
//

import Foundation
import Combine
import App
import XCTest
import Data
import Shared

final class MarvelHttpRepositoryTests: XCTestCase {
    
    private let combineServiceMock = CombineNetworkServiceMock()
    private var sut: MarvelHttpRepository!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        sut = MarvelHttpRepository(networkService: combineServiceMock)
    }
    
    func testShouldFindCharacters() throws {
        // Given
        let json =
        "{\"code\":200,\"status\":\"Ok\",\"data\":{\"offset\":0,\"limit\":1,\"total\":1561,\"count\":1,\"results\":[{\"id\":1011334,\"name\":\"3-D Man\",\"description\":\"Description\",\"modified\":\"2014-04-29T14:18:17-0400\",\"thumbnail\":{\"path\":\"path\",\"extension\":\"jpg\"}}]}}"
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .utf8
        let data = Data(json)
        let mockResponse = try JSONDecoder().decode(CharactersResponse?.self, from: data)
        combineServiceMock.stubbedRequestResult = mockResponse
        let exp = expectation(description: "Find Characters")
        
        // When
        let result = sut.findCharacters(limit: 20, offset: 0, search: nil, sorting: nil)
        
        // Then
        XCTAssertEqual(combineServiceMock.invokedRequestCount, 1)
        
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
    
    func testShouldFindComics() throws {
        // Given
        let json =
        "{\"code\":200,\"status\":\"Ok\",\"data\":{\"offset\":0,\"limit\":20,\"total\":2602,\"count\":20,\"results\":[{\"id\":27238,\"digitalId\":0,\"title\":\"Wolverine Saga (2009) #7\",\"thumbnail\":{\"path\":\"http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available\",\"extension\":\"jpg\"}}]}}"
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .utf8
        let data = Data(json)
        let mockResponse = try JSONDecoder().decode(ComicsResponse?.self, from: data)
        combineServiceMock.stubbedRequestResult = mockResponse
        let exp = expectation(description: "Find Comics")
        
        // When
        let result = sut.findComics(characterId: 1)
        
        // Then
        XCTAssertEqual(combineServiceMock.invokedRequestCount, 1)
        
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


