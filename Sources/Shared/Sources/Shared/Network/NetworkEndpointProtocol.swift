//
//  NetworkEndpointProtocol.swift
//
//
//  Created by Marcelo Silva on 20/04/22.
//

import Foundation

public enum HTTPMethod: String {
    case delete
    case get
    case patch
    case post
    case put
    case head
}

public protocol NetworkEndpointProtocol {
    var cachePolicy: URLRequest.CachePolicy { get }
    var headers: [String: String]? { get }
    var httpBody: Data? { get }
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var queryParams: [String: String]? { get }
}

public extension NetworkEndpointProtocol {
    var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }
    var httpBody: Data? { nil }
    var queryParams: [String: String]? { nil }
}
