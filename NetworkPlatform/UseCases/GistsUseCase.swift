//
//  GistsUseCase.swift
//  NetworkPlatform
//
//  Created by Norberto Vasconcelos on 08/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class GistsUseCase: Domain.GistsUseCase {
    
    let network: GistsNetwork
    
    init(network: GistsNetwork) {
        self.network = network
    }
    
    func gists() -> Observable<[Gist]> {
        return network.fetchGists()
    }
    
    func gist(id: String) -> Observable<Gist> {
        return network.fetchGist(gistId: id)
    }
    
}
