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
    
    private var numberOfColumns: CGFloat = 3
    private let interactor: SearchViewIneractorable = SearchViewInteractor(service: PhotoServiceManager())
    private let localize: SearchViewLocalizeStrings = SearchViewLocalizeStrings()
    
    private(set) var searchBarController: UISearchController? = nil
    private(set) weak var collectionView: UICollectionView? = nil

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
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.backgroundColor = UIColor.white
       
        collectionView.register(SearchViewCollectionCell.self, forCellWithReuseIdentifier: "SearchViewCollectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: -10),
            self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 10),
            self.view.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0),
            self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0),
        ])
        self.collectionView = collectionView
        
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

//MARK:- UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchViewCollectionCell",
                                                      for: indexPath) as! SearchViewCollectionCell
        cell.imageView?.image = nil
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? SearchViewCollectionCell else {
            return
        }
        
//        let model = viewModel.photos[indexPath.row]
//        cell.model = model
        
//        if indexPath.row == (viewModel.photoArray.count - 10) {
//            loadNextPage()
//        }
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width)/numberOfColumns,
                      height: (collectionView.bounds.width)/numberOfColumns)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
