//
//  MarvelCharacterRepository.swift
//  
//
//  Created by Marcelo Silva on 16/4/22.
//

import Combine
import Shared

public protocol MarvelCharacterRepositoryProtocol {
    func getCharacters(limit: Int, offset: Int) -> AnyPublisher<[Character], NetworkError>
}
