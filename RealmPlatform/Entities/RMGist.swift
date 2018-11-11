//
//  RMGist.swift
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


final class RMGist: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var gistDescription: String = ""
    @objc dynamic var numberOfComments: Int = 0
    @objc dynamic var owner: RMUser?
    @objc dynamic var createdAt: String = ""
    @objc dynamic var updatedAt: String = ""

    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension RMGist {
    static var id: Attribute<String> { return Attribute("id")}
    static var gistDescription: Attribute<String> { return Attribute("gistDescription")}
    static var numberOfComments: Attribute<Int> { return Attribute("numberOfComments")}
    static var owner: Attribute<RMUser> { return Attribute("owner")}
    static var createdAt: Attribute<String> { return Attribute("createdAt")}
    static var updatedAt: Attribute<String> { return Attribute("updatedAt")}
}

extension RMGist: DomainConvertibleType {
    func asDomain() -> Gist {
        return Gist(id: id,
                    description: description,
                    numberOfComments: numberOfComments,
                    owner: owner!.asDomain(),
                    createdAt: createdAt,
                    updatedAt: createdAt)
    }
}

extension Gist: RealmRepresentable {
    func asRealm() -> RMGist {
        return RMGist.build { object in
            object.id = id
            object.gistDescription = description
            object.numberOfComments = numberOfComments
            object.owner = owner.asRealm()
            object.createdAt = createdAt?.getString ?? ""
            object.updatedAt = updatedAt?.getString ?? ""
        }
    }
}
