//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by Norberto Vasconcelos on 08/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    
    private let networkProvider: NetworkProvider
    
    public init() {
        networkProvider = NetworkProvider()
    }
    
    public func makeGistsUseCase() -> Domain.GistsUseCase {
        return GistsUseCase(network: networkProvider.makeGistsNetwork())
    }
}
