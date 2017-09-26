//
//  RecipeNetworkService.swift
//  mo2oTest
//
//  Created by Graciela Lucena on 9/26/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

struct RecipeNetworkService {
    
    struct Key {
        static let results = "results"
    }
    
    
    static func searchRecipes(with keyword: String, onCompletion completion: RecipeCompletion?) {
        Alamofire.request(Router.getPuppyRecipe(name: keyword)).validate().responseJSON { response in
            var result: Result<[Recipe]> = Result.success([Recipe]())
            
            switch response.result {
                
            case .success(let jsonDictionary):
                
                if let json = jsonDictionary as? jsonDictionary {
                    
                    do {
                        let recipes: [Recipe] = try unbox(dictionary: json, atKey: Key.results)
                        result = Result.success(recipes)
                    } catch let error {
                        result = Result.failure(error)
                    }
                }
                
            case .failure(let error):
                result = Result.failure(error)
            }
            
            if let completion = completion {
                completion(result.value ?? [], result.error)
            }
        }
    }
}
