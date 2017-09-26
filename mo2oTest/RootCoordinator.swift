//
//  RootCoordinator.swift
//  mo2oTest
//
//  Created by Graciela Lucena on 9/26/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit

class RootCoordinator: Coordinator {
    
    private var window: UIWindow
    private var coordinators: CoordinatorsDictionary
    
    var rootViewController: UIViewController {
        let coordinator = coordinators.popFirst()!.1
        
        return coordinator.rootViewController
    }
    
    // MARK: - Initializers
    
    init(window: UIWindow) {
        self.window = window
        coordinators = [:]
    }
    
    // MARK: - Coordinator
    
    func start() {
        showHome()
    }
    
    // MARK: Helpers
    
    private func showHome() {
        let homeCoordinator = HomeCoordinator()
        coordinators[homeCoordinator.name] = homeCoordinator
        window.rootViewController = homeCoordinator.rootViewController
        homeCoordinator.start()
    }
}
