//
//  SearchViewController.swift
//  Interview_Demo
//
//  Created by Kushagara on 13/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import UIKit

private enum SearchViewControllerAccessibleIds : String {
    case searchBarId = "search_bar_accessibilityid"
}

final class SearchViewController: UIViewController {
    
    private(set) var viewModel : SearchViewModel = SearchViewModel(photos: [])
    
    private let interactor: SearchViewIneractorable = SearchViewInteractor()
    private let localize: SearchViewLocalizeStrings = SearchViewLocalizeStrings()
    
    private(set) var searchBarController: UISearchController? = nil
    private(set) var collectionView: UICollectionView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.startProgress()
        self.interactor.getPhotos()
    }
    
    private func setupUI() {
        self.createSearchBar()
        self.title = localize.title
        self.createCollectionView()
    }

    func startProgress() {
        
    }
    
    func stopProgress() {
        
    }
    
    private func createSearchBar() {
        searchBarController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchBarController
        self.searchBarController?.searchBar.accessibilityIdentifier = SearchViewControllerAccessibleIds.searchBarId.rawValue
        self.searchBarController?.delegate = self
        self.searchBarController?.searchBar.delegate = self
        searchBarController?.isActive = true
    }
    
    private func createCollectionView() {
    }
    
    private func createNoContentView() {
        
    }

}

extension SearchViewController: SearchViewControllable {
    
    func updatePhotos(photos: [PhotoViewModel]) {
        self.stopProgress()
    }
}

extension SearchViewController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, text.count > 1 else {
            return
        }
        
        searchBarController?.searchBar.resignFirstResponder()
    }
}
