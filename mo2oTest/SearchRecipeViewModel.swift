//
//  SearchRecipeViewModel.swift
//  mo2oTest
//
//  Created by Graciela Lucena on 9/26/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation

protocol SearchRecipeViewModelViewDelegate: class {
    func recipeDidChange(viewModel: SearchRecipeViewModel)
}

protocol SearchRecipeViewModel: class {
    var viewDelegate: SearchRecipeViewModelViewDelegate? { get set }
    
    var searchText: String? { get set }
    
    func numberOfRecipes() -> Int
    func recipeAt(index: Int) -> RecipeItem!
}

class SearchRecipeAPIViewModel: SearchRecipeViewModel {
    var viewDelegate: SearchRecipeViewModelViewDelegate?
        
    private var apiRecipes: [Recipe]! = [] {
        didSet { items = apiRecipes.map { RecipeItem(recipe: $0) } }
    }
    
    private var items: [RecipeItem]? {
        didSet {
            DispatchQueue.main.async() { [unowned self] in
                self.viewDelegate?.recipeDidChange(viewModel: self)
            }
        }
    }
    
    var searchText: String? {
        didSet {
            guard let searchText = searchText, !searchText.isEmpty else {
                return
            }
            
            searchRecipes()
        }
    }
    
    func numberOfRecipes() -> Int {
        return items?.count ?? 0
    }
    
    func recipeAt(index: Int) -> RecipeItem! {
        return items?[index]
    }
    
    func searchRecipes() {
        
        RecipeAPI.searchRecipes(with: searchText!) { (recipes, error) in
            self.apiRecipes = recipes
        }
    }
}

struct RecipeItem {
    
    let title: String
    let href: String
    let ingredients: String
    let thumbnail: String?
    
    var imageURL: URL? {
        
        guard let imageURL = thumbnail, let url = URL(string: imageURL) else {
            return nil
        }
        
        return url
    }
    init(recipe: Recipe) {
        self.title = recipe.title
        self.href = recipe.href
        self.ingredients = recipe.ingredients
        self.thumbnail = recipe.thumbnail
        
    }
}
