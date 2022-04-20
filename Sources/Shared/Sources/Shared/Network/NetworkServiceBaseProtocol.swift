//
//  NetworkServiceBaseProtocol.swift
//
//
//  Created by Marcelo Silva on 20/04/22.
//
import Foundation

protocol NetworkServiceBaseProtocol {
    var environment: NetworkEnvironmentProtocol { get }
}

extension NetworkServiceBaseProtocol {
    func urlRequest(endpoint: NetworkEndpointProtocol) -> URLRequest? {
        guard let url = URL(string: environment.baseURL + endpoint.path) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = endpoint.cachePolicy
        urlRequest.timeoutInterval = environment.timeoutInterval
        urlRequest.httpMethod = endpoint.httpMethod.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = endpoint.headers
        urlRequest.httpBody = endpoint.httpBody

        return urlRequest
    }
}
