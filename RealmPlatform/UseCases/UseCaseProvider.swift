//
//  UseCaseProvider.swift
//  RealmPlatform
//
//  Created by Norberto Vasconcelos on 09/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import Realm
import RealmSwift

public final class UseCaseProvider: Domain.UseCaseProvider {
    
    private let configuration: Realm.Configuration
    
    public init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
    }
    
    public func makeGistsUseCase() -> Domain.GistsUseCase {
        let repository = Repository<Gist>(configuration: configuration)
        return GistsUseCase(repository: repository) as GistsCacheUseCase
    }
}
