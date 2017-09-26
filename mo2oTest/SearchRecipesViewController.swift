//
//  SearchRecipesViewController.swift
//  mo2oTest
//
//  Created by Graciela Lucena on 9/26/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit

class SearchRecipesViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: SearchRecipeViewModel
    
    // MARK: Lifecycle
    init(viewModel: SearchRecipeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: SearchRecipesViewController.self), bundle: nil)
        viewModel.viewDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        configureCollectionView()
    }
    
    // MARK: - Helpers
    
    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        navigationItem.titleView = searchController.searchBar
    }
    
    func configureCollectionView() {
        collectionView.register(UINib(nibName: String(describing: RecipeCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: RecipeCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UISearchBarDelegate
extension SearchRecipesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UISearchResultsUpdating

extension SearchRecipesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchText = searchController.searchBar.text
    }
}

// MARK: - UICollectionViewDataSource

extension SearchRecipesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRecipes()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RecipeCollectionViewCell.self), for: indexPath)
        
        if let cell = cell as? RecipeCollectionViewCell {
            let item = viewModel.recipeAt(index: indexPath.row)
            
            cell.nameLabel.text = item?.title
            
            if let imageURL = item?.imageURL {
                cell.imageView.loadImage(with: imageURL, placeholderImage: nil)
            }
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchRecipesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

// MARK: - SearchRecipeViewModelViewDelegate
extension SearchRecipesViewController: SearchRecipeViewModelViewDelegate {
    
    func recipeDidChange(viewModel: SearchRecipeViewModel) {
        collectionView.reloadData()
    }
}

