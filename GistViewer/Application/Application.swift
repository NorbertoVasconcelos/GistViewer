//
//  Application.swift
//  GistViewer
//
//  Created by Norberto Vasconcelos on 08/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import NetworkPlatform
import RealmPlatform

final class Application {
    static let shared = Application()
    
    private let realmUseCaseProvider: Domain.UseCaseProvider
    private let networkUseCaseProvider: Domain.UseCaseProvider
    
    private init() {
        self.realmUseCaseProvider = RealmPlatform.UseCaseProvider()
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }
    
    func configureMainInterface(in window: UIWindow) {
        
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        let gistsNavigator = DefaultGistsNavigator(useCase: networkUseCaseProvider.makeGistsUseCase(),
                                                   cachedUseCase: realmUseCaseProvider.makeGistsUseCase() as! GistsCacheUseCase,
                                                   navigationController: navigationController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        gistsNavigator.toGists()
    }
}
