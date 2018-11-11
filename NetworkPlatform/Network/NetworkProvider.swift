//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by Norberto Vasconcelos on 08/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import RealmPlatform
import Realm
import RealmSwift
import RxSwift
import RxRealm

final class NetworkProvider {
    private let apiEndpoint: String
    
    public init() {
        apiEndpoint = "https://api.github.com"
    }
    
    public func makeGistsNetwork() -> GistsNetwork {
        let network = Network<Gist>(apiEndpoint)
        return GistsNetwork(network: network)
    }
}
