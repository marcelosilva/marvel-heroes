//
//  CharacterEntity.swift
//  
//
//  Created by Marcelo Silva on 18/4/22.
//

public class CharacterEntity: Codable, Equatable {
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: ThumbnailEntity
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        thumbnail = try values.decode(ThumbnailEntity.self, forKey: .thumbnail)
    }

    public static func ==(lhs: CharacterEntity, rhs: CharacterEntity) -> Bool {
        lhs.id == rhs.id
    }

}
