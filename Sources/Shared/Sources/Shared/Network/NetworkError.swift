//
//  NetworkError.swift
//
//
//  Created by Marcelo Silva on 20/04/22.
//

import Combine

public enum NetworkError: Error, Equatable {
    case decodingError
    case httpError(Int)
    case invalidURL
    case unknown
}
