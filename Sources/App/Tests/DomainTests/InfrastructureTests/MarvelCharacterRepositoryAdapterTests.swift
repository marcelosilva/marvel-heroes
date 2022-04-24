//
//  MarvelCharacterRepositoryAdapterTests.swift
//  
//
//  Created by Marcelo Silva on 22/4/22.
//

import Foundation
import Combine
@testable import App
import XCTest
import Data

final class MarvelCharacterRepositoryAdapterTests: XCTestCase {
    
    private let httpRepository = MarvelHttpRepositoryMock()
    private var sut: MarvelCharacterRepositoryAdapter!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        sut = MarvelCharacterRepositoryAdapter(marvelHttpRepository: httpRepository)
    }
    
    func testShouldReturnComicsWhenFinding() throws {
        // Given
        let json =
        "{\"code\":200,\"status\":\"Ok\",\"data\":{\"offset\":0,\"limit\":20,\"total\":2602,\"count\":20,\"results\":[{\"id\":27238,\"digitalId\":0,\"title\":\"Wolverine Saga (2009)\",\"thumbnail\":{\"path\":\"http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available\",\"extension\":\"jpg\"}}]}}"
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .utf8
        let data = Data(json)
        let mockResponse = try JSONDecoder().decode(ComicsResponse?.self, from: data)
        
        let expectedComics = [
            ComicObjectMother()
                .withId(id: 27238)
                .withTitle(title: "Wolverine Saga (2009)")
                .withThumbnailUrl(thumbnailUrl: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available")
                .build()
        ]
        
        httpRepository.stubbedFindComicsResult = mockResponse
        let exp = expectation(description: "Get Comics")
        
        // When
        let result = sut.getComics(characterId: 10)
        
        // Then
        XCTAssertEqual(httpRepository.invokedFindComicsCount, 1)
        XCTAssertEqual(httpRepository.invokedFindComicsParameters?.characterId, 10)
        
        result
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Test failed. error")
                case .finished:
                    break
                }
            }, receiveValue: { comics in
                XCTAssertEqual(comics, expectedComics)
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 3)
    }
    
    func testShouldReturnCharactersWhenFinding() throws {
        // Given
        let json =
        "{\"code\":200,\"status\":\"Ok\",\"data\":{\"offset\":0,\"limit\":1,\"total\":1561,\"count\":1,\"results\":[{\"id\":1011334,\"name\":\"3-D Man\",\"description\":\"Description\",\"modified\":\"2014-04-29T14:18:17-0400\",\"thumbnail\":{\"path\":\"path\",\"extension\":\"jpg\"}}]}}"
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .utf8
        let data = Data(json)
        let mockResponse = try JSONDecoder().decode(CharactersResponse?.self, from: data)
        
        let expectedCharacters = [
            CharacterObjectMother()
                .withId(id: 1011334)
                .withName(name: "3-D Man")
                .withDescription(description: "Description")
                .withThumbnail(thumbnail: Thumbnail(url: "path"))
                .withComics(comics: nil)
                .build()
        ]
        
        httpRepository.stubbedFindCharactersResult = mockResponse
        let queryRequest = QueryRequestObjectMother().build()
        let exp = expectation(description: "Get Characters")
        
        // When
        let result = sut.getCharacters(queryRequest: queryRequest)
        
        // Then
        XCTAssertEqual(httpRepository.invokedFindCharactersCount, 1)
        XCTAssertEqual(httpRepository.invokedFindCharactersParameters?.limit, queryRequest.limit)
        XCTAssertEqual(httpRepository.invokedFindCharactersParameters?.offset, queryRequest.offset)
        XCTAssertEqual(httpRepository.invokedFindCharactersParameters?.sorting, queryRequest.sorting)
        XCTAssertEqual(httpRepository.invokedFindCharactersParameters?.search, queryRequest.search)
        
        result
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Test failed. error")
                case .finished:
                    break
                }
            }, receiveValue: { characters in
                XCTAssertEqual(characters, expectedCharacters)
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 3)
    }
}


