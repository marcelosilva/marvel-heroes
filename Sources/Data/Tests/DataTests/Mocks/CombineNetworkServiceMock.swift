//
//  CombineNetworkServiceMock.swift
//  
//
//  Created by Marcelo Silva on 22/4/22.
//

import Foundation
import Shared
import Data
import Combine

public class CombineNetworkServiceMock: CombineNetworkServiceProtocol {

    var invokedRequest = false
    var invokedRequestCount = 0
    var invokedRequestParameters: (endpoint: NetworkEndpointProtocol, Void)?
    var invokedRequestParametersList = [(endpoint: NetworkEndpointProtocol, Void)]()
    var stubbedRequestResult: Decodable!

    public func request<Decodable>(with endpoint: NetworkEndpointProtocol) -> AnyPublisher<Decodable, NetworkError> {
        invokedRequest = true
        invokedRequestCount += 1
        invokedRequestParameters = (endpoint, ())
        invokedRequestParametersList.append((endpoint, ()))
        
        guard let dataStub = stubbedRequestResult else {
            return Fail(error: NetworkError.httpError(409))
                .eraseToAnyPublisher()
        }
        
        return Just(dataStub as! Decodable)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}
