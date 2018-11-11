//
//  GistsNavigator.swift
//  GistViewer
//
//  Created by Norberto Vasconcelos on 08/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import UIKit
import Domain

protocol GistsNavigator {
    func toGists()
    func toGist(_ gist: Gist)
}

class DefaultGistsNavigator: GistsNavigator {
    
    var useCase: GistsUseCase
    var cachedUseCase: GistsCacheUseCase
    var navigationController: UINavigationController
    
    init(useCase: GistsUseCase,
         cachedUseCase: GistsCacheUseCase,
         navigationController: UINavigationController) {
        self.useCase = useCase
        self.cachedUseCase = cachedUseCase
        self.navigationController = navigationController
    }
    
    func toGists() {
        let gistsViewModel = GistsViewModel(useCase: useCase,
                                            cachedUseCase: cachedUseCase,
                                            navigator: self)
        
        let gistsViewController = GistsViewController()
        gistsViewController.viewModel = gistsViewModel
        
        navigationController.pushViewController(gistsViewController, animated: true)
    }
    
    func toGist(_ gist: Gist) {
        let gistDetailNavigator = DefaultGistDetailNavigator(useCase: useCase,
                                                      cachedUseCase: cachedUseCase,
                                                      navigationController: navigationController)
        let gistDetailViewModel = GistDetailViewModel(useCase: useCase,
                                                      cachedUseCase: cachedUseCase,
                                                      navigator: gistDetailNavigator,
                                                      gist: gist)
        let gistDetailViewController = GistDetailViewController()
        gistDetailViewController.viewModel = gistDetailViewModel
        if let gistsVC = navigationController.topViewController as? GistsViewController {
            navigationController.delegate = gistsVC
        }
        
        navigationController.pushViewController(gistDetailViewController, animated: true)
    }
}
