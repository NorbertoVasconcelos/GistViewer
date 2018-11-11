//
//  GistsViewModel.swift
//  GistViewer
//
//  Created by Norberto Vasconcelos on 08/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class GistsViewModel: ViewModelType {
    
    struct Input {
        let trigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let gists: Driver<[Gist]>
        let selectedGist: Driver<Gist>
        let error: Driver<Error>
    }
    
    private let useCase: GistsUseCase
    private let cachedUseCase: GistsCacheUseCase
    private let navigator: GistsNavigator
    
    init(useCase: GistsUseCase, cachedUseCase: GistsUseCase, navigator: GistsNavigator) {
        self.useCase = useCase
        self.cachedUseCase = cachedUseCase as! GistsCacheUseCase
        self.navigator = navigator
    }
    
    func transform(input: GistsViewModel.Input) -> GistsViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let cachedGists = self.cachedUseCase.gists().asDriverOnErrorJustComplete()
        
        let gists = input.trigger.flatMapLatest { _ in
            return self.useCase.gists()
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriver(onErrorDriveWith: { cachedGists }())
                .do(onNext: {
                    let _ = $0.map { self.cachedUseCase.save(gist: $0).subscribe() }
                })
            

        }
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        let selectedGist = input.selection.withLatestFrom(gists) {
            indexPath, gists -> Gist in
            let selectedGist = gists[indexPath.row]
            self.navigator.toGist(selectedGist)
            return selectedGist
        }
        return Output(fetching: fetching,
                      gists: gists,
                      selectedGist: selectedGist,
                      error: errors)
    }
}
