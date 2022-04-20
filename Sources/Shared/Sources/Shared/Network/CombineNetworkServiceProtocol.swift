//
//  CombineNetworkServiceProtocol.swift
//
//
//  Created by Marcelo Silva on 20/04/22.
//

import Combine
import Foundation

public protocol CombineNetworkServiceProtocol {
    func request<T: Decodable>(with endpoint: NetworkEndpointProtocol) -> AnyPublisher<T, NetworkError>
}
