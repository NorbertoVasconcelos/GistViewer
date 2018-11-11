//
//  User.swift
//  Domain
//
//  Created by Norberto Vasconcelos on 08/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation

public struct User: Codable {
    public var id: String
    public var username: String
    public var avatarUrl: String
    
    
    private enum CodingKeys: String, CodingKey {
        case id
        case username = "login"
        case avatarUrl = "avatar_url"
    }
    
    public init() {
        self.id = ""
        self.username = ""
        self.avatarUrl = ""
    }
    
    public init(id: String, username: String, avatarUrl: String) {
        self.id = id
        self.username = username
        self.avatarUrl = avatarUrl
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let idInt = try container.decode(Int.self, forKey: .id)
        id = String(idInt)
        username = try container.decode(String.self, forKey: .username)
        avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
    }
}
