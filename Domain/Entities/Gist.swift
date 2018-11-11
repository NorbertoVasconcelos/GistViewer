//
//  Gist.swift
//  Domain
//
//  Created by Norberto Vasconcelos on 08/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation

public struct Gist: Codable {
    public var id: String
    public var description: String
    public var numberOfComments: Int
    public var owner: User
    public var createdAt: Date?
    public var updatedAt: Date?
    
    
    private enum CodingKeys: String, CodingKey {
        case id
        case description
        case numberOfComments = "comments"
        case owner
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    public init() {
        self.id = ""
        self.description = ""
        self.numberOfComments = 0
        self.owner = User()
    }
    
    public init(id: String, description: String, numberOfComments: Int, owner: User, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.description = description
        self.numberOfComments = numberOfComments
        if let _createdAt = createdAt, let date = Formatter.dateOnly.date(from: _createdAt)  {
            self.createdAt = date
        }
        if let _updatedAt = updatedAt, let date = Formatter.dateOnly.date(from: _updatedAt)  {
            self.updatedAt = date
        }
        
        self.owner = owner
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        numberOfComments = try container.decode(Int.self, forKey: .numberOfComments)
        owner = try container.decode(User.self, forKey: .owner)
        let createdAtString = try container.decode(String.self, forKey: .createdAt)
        if let date = Formatter.dateOnly.date(from: createdAtString)  {
            createdAt = date
        }
        let updatedAtString = try container.decode(String.self, forKey: .updatedAt)
        if let date = Formatter.dateOnly.date(from: updatedAtString)  {
            updatedAt = date
        }
    }
}
