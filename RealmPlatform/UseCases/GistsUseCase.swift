//
//  GistsUseCase.swift
//  RealmPlatform
//
//  Created by Norberto Vasconcelos on 09/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import Realm
import RealmSwift

final class GistsUseCase<Repository>: Domain.GistsCacheUseCase where Repository: AbstractRepository, Repository.T == Gist {
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func gists() -> Observable<[Gist]> {
        print("Getting gists.")
        return repository.queryAll()
    }
    
    func gist(id: String) -> Observable<Gist> {
//        let predicate = NSPredicate()
//        let descriptors: [NSSortDescriptor] = []
//        return repository.query(with: predicate, sortDescriptors: descriptors)
        return Observable.just(Gist())
    }
    
    func save(gist: Gist) -> Observable<Void> {
        return repository.save(entity: gist)
    }
    
    func delete(gist: Gist) -> Observable<Void> {
        return repository.delete(entity: gist)
    }
}
