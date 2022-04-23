//
//  CharactersEndpoint.swift
//  
//
//  Created by Marcelo Silva on 23/4/22.
//

import Foundation
import Shared

public class CharactersEndpoint: NetworkEndpointProtocol, Equatable {
    public var headers: [String: String]?
    public var path: String = "/characters"
    public var httpMethod = HTTPMethod.get
    
    public static func getEndpoint(
        limit: Int,
        offset: Int,
        search: String?,
        sorting: String?
    ) -> CharactersEndpoint {
        let endpoint = CharactersEndpoint()
        endpoint.path += "\(MarvelNetworkEnvironment.getSecurityParameters())&limit=\(limit)&offset=\(offset)"
        
        if let search = search, search.count > 0 {
            let encodedSearch = search
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? search
            endpoint.path += "&nameStartsWith=\(encodedSearch)"
        }
        
        if let sorting = sorting {
            endpoint.path += "&orderBy=\(sorting)"
        }
        return endpoint
    }
    
    public static func == (lhs: CharactersEndpoint, rhs: CharactersEndpoint) -> Bool {
        return lhs.path == rhs.path && lhs.httpMethod == rhs.httpMethod
    }
}
