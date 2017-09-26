//
//  HomeCoordinator.swift
//  mo2oTest
//
//  Created by Graciela Lucena on 9/26/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    var rootViewController: UIViewController
    private var coordinators: [String: Coordinator]
    
    private var tabBarController: UITabBarController {
        return rootViewController as! UITabBarController
    }
    
    enum Section: Int {
        case Search
    }
    
    init() {
        rootViewController = UITabBarController()
        coordinators = [:]
    }
    
    func start() {
        let searchCoordinator = SearchCoordinator()
        let searchNavController = searchCoordinator.rootViewController
        
        coordinators[searchCoordinator.name] = searchCoordinator
        
        tabBarController.viewControllers = [searchNavController]

        searchCoordinator.start()
        
        showSearch()
    }
    
    func showSearch() {
        tabBarController.selectedIndex = Section.Search.rawValue
    }    
}


