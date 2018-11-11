//
//  RMUser.swift
//  RealmPlatform
//
//  Created by Norberto Vasconcelos on 09/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import QueryKit
import Domain
import RealmSwift
import Realm


final class RMUser: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var avatarUrl: String = ""
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension RMUser {
    static var id: Attribute<String> { return Attribute("id")}
    static var username: Attribute<String> { return Attribute("username")}
    static var avatarUrl: Attribute<Int> { return Attribute("avatarUrl")}
}

extension RMUser: DomainConvertibleType {
    func asDomain() -> User {
        return User(id: id,
                    username: username,
                    avatarUrl: avatarUrl)
    }
}

extension User: RealmRepresentable {
    
    func asRealm() -> RMUser {
        return RMUser.build { object in
            object.id = id
            object.username = username
            object.avatarUrl = avatarUrl
        }
    }
}
