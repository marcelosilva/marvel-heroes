//
//  CharactersResponse.swift
//  
//
//  Created by Marcelo Silva on 21/4/22.
//

import Foundation

public class CharactersResponse: Codable, Equatable {
    public let code: Int
    public let status: String
    public let data: CharactersResponseData
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decode(Int.self, forKey: .code)
        status = try values.decode(String.self, forKey: .status)
        data = try values.decode(CharactersResponseData.self, forKey: .data)
    }
    
    public static func == (lhs: CharactersResponse, rhs: CharactersResponse) -> Bool {
        lhs.code == rhs.code && lhs.data == rhs.data
    }
}

public class CharactersResponseData: Codable, Equatable {
    public let offset: Int
    public let limit: Int
    public let total: Int
    public let count: Int
    public let results: [CharacterEntity]
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        offset = try values.decode(Int.self, forKey: .offset)
        limit = try values.decode(Int.self, forKey: .limit)
        total = try values.decode(Int.self, forKey: .total)
        count = try values.decode(Int.self, forKey: .count)
        results = try values.decode([CharacterEntity].self, forKey: .results)
    }
    
    public static func == (lhs: CharactersResponseData, rhs: CharactersResponseData) -> Bool {
        lhs.results == rhs.results && lhs.offset == rhs.offset && lhs.limit == rhs.limit
    }
    
    
}
