//
//  GistsNetwork.swift
//  NetworkPlatform
//
//  Created by Norberto Vasconcelos on 08/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import RxSwift
import Domain
import RealmPlatform


public final class GistsNetwork {
    private let network: Network<Gist>
    
    init(network: Network<Gist>) {
        self.network = network
    }
    
    public func fetchGists() -> Observable<[Gist]> {
        return network.getItems("gists")
    }
    
    public func fetchGist(gistId: String) -> Observable<Gist> {
        return network.getItem("gists", itemId: gistId)
    }
}
