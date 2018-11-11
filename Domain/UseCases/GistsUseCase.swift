//
//  GistsUseCase.swift
//  Domain
//
//  Created by Norberto Vasconcelos on 08/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import RxSwift

public protocol GistsUseCase {
    func gists() -> Observable<[Gist]>
    func gist(id: String) -> Observable<Gist>
}

public protocol GistsCacheUseCase: GistsUseCase {
    func gists() -> Observable<[Gist]>
    func gist(id: String) -> Observable<Gist>
    func save(gist: Gist) -> Observable<Void>
    func delete(gist: Gist) -> Observable<Void>
}
