//
//  SearchCoordinator.swift
//  mo2oTest
//
//  Created by Graciela Lucena on 9/26/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit

class SearchCoordinator: Coordinator {
    
    var rootViewController: UIViewController
    
    private var navigationController: UINavigationController {
        return rootViewController as! UINavigationController
    }
    
    init() {
        rootViewController = UINavigationController()
    }
    
    func start() {
        let searchRecipeVM = SearchRecipeAPIViewModel()
        let searchRecipeVC = SearchRecipesViewController(viewModel: searchRecipeVM)
        navigationController.setViewControllers([searchRecipeVC], animated: false)
    }
}
