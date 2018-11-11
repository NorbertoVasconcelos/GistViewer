//
//  GistDetailViewModel.swift
//  GistViewer
//
//  Created by Norberto Vasconcelos on 10/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class GistDetailViewModel: ViewModelType {

    struct Input {
        let trigger: Driver<Void>
        let back: Driver<Void>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let gist: Driver<Gist>
        let back: Driver<Void>
        let error: Driver<Error>
    }
    
    private let useCase: GistsUseCase
    private let cachedUseCase: GistsCacheUseCase
    private let navigator: GistDetailNavigator
    var gist: Gist
    
    init(useCase: GistsUseCase,
         cachedUseCase: GistsUseCase,
         navigator: GistDetailNavigator,
         gist: Gist) {
        self.useCase = useCase
        self.cachedUseCase = cachedUseCase as! GistsCacheUseCase
        self.navigator = navigator
        self.gist = gist
    }
    
    func transform(input: GistDetailViewModel.Input) -> GistDetailViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let gist = input.trigger.flatMapLatest { _ in
            return Observable.just(self.gist).asDriverOnErrorJustComplete()
        }
        
        let back = input.back.do(onNext: { self.navigator.toGists() })
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()

        return Output(fetching: fetching,
                      gist: gist,
                      back: back,
                      error: errors)
    }
}
