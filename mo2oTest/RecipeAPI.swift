//
//  RecipeAPI.swift
//  mo2oTest
//
//  Created by Graciela Lucena on 9/26/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation

typealias RecipeCompletion = (([Recipe], Error?) -> Void)

struct RecipeAPI {
    
    static func searchRecipes(with keyword: String, completion: RecipeCompletion?) {
        return RecipeNetworkService.searchRecipes(with:keyword, onCompletion:completion)
    }

}
