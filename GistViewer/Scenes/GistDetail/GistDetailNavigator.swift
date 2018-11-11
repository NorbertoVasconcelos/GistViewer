//
//  GistDetailNavigator.swift
//  GistViewer
//
//  Created by Norberto Vasconcelos on 10/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import UIKit
import Domain

protocol GistDetailNavigator {
    func toGists()
}

class DefaultGistDetailNavigator: GistDetailNavigator {
    
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
        navigationController.dismiss(animated: true)
    }
}
