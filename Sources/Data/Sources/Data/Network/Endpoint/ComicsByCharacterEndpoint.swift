//
//  ComicsByCharacterEndpoint.swift
//  
//
//  Created by Marcelo Silva on 23/4/22.
//

import Foundation
import Shared

public class ComicsByCharacterEndpoint: NetworkEndpointProtocol, Equatable {
    public var headers: [String: String]?
    public var path: String = "/characters"
    public var httpMethod = HTTPMethod.get
    
    public static func getEndpoint(characterId: Int) -> ComicsByCharacterEndpoint {
        let endpoint = ComicsByCharacterEndpoint()
        endpoint.path += "/\(characterId)/comics\(MarvelNetworkEnvironment.getSecurityParameters())"
        return endpoint
    }
    
    public static func == (lhs: ComicsByCharacterEndpoint, rhs: ComicsByCharacterEndpoint) -> Bool {
        return lhs.path == rhs.path && lhs.httpMethod == rhs.httpMethod
    }
}
