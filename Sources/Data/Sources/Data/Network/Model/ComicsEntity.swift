//
//  ComicsEntity.swift
//  
//
//  Created by Marcelo Silva on 23/4/22.
//

public class ComicsEntity: Codable, Equatable {
    public let id: Int
    public let title: String
    public let thumbnail: ThumbnailEntity
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        thumbnail = try values.decode(ThumbnailEntity.self, forKey: .thumbnail)
    }
    
    public static func ==(lhs: ComicsEntity, rhs: ComicsEntity) -> Bool {
        lhs.id == rhs.id
    }
    
}
