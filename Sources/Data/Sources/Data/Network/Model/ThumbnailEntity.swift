//
//  ThumbnailEntity.swift
//  
//
//  Created by Marcelo Silva on 23/4/22.
//

import Foundation

public class ThumbnailEntity: Codable {
    public let path: String
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decode(String.self, forKey: .path)
    }
    
}
