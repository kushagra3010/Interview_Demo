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

final class SearchViewController: UIViewController, SearchViewControllable {
    
    private(set) var viewModel : SearchViewModel = SearchViewModel(photos: [])
    
    private let numberOfColumns: CGFloat = 3
    private let interactor: SearchViewIneractorable
    private let localize: SearchViewLocalizeStrings = SearchViewLocalizeStrings()
    
    private(set) var searchBarController: UISearchController? = nil
    private(set) weak var collectionView: UICollectionView? = nil
    private(set) weak var noContentLabel : UILabel? = nil
    private(set) weak var activityIndicator: UIActivityIndicatorView? = nil
    
    private struct SearchViewConstants {
        static let noContentLabelFontSize: CGFloat = 20.0
    }
    
    init(interactor: SearchViewIneractorable) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.startProgress()
        self.startProgress()
        self.interactor.getPhotos(searchTerm: nil)
    }
    
    private func setupUI() {
        self.createSearchBar()
        self.title = localize.title
        self.view.backgroundColor = .white
        self.createCollectionView()
        self.createNoContentView()
        self.createIndicator()
    }

    func createIndicator() {
        let indicator = UIActivityIndicatorView(style: .large)
        self.view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.view.centerXAnchor.constraint(equalTo: indicator.centerXAnchor, constant: 0),
            self.view.centerYAnchor.constraint(equalTo: indicator.centerYAnchor, constant: 0)
        ])
        indicator.isHidden = true
        self.activityIndicator = indicator
    }
    
    func startProgress() {
        self.activityIndicator?.isHidden = false
        self.activityIndicator?.startAnimating()
    }
    
    func stopProgress() {
        self.activityIndicator?.isHidden = true
        self.activityIndicator?.stopAnimating()
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
            self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 0),
            self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 0),
            self.view.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0),
            self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0),
        ])
        self.collectionView = collectionView
        
    }
    
    private func createNoContentView() {
        
        let noContentLabel = UILabel()
        noContentLabel.textAlignment = .center
        noContentLabel.numberOfLines = 0
        noContentLabel.backgroundColor = .white
        noContentLabel.font = UIFont.boldSystemFont(ofSize: SearchViewConstants.noContentLabelFontSize)
        noContentLabel.text = localize.noContentText
        self.view.addSubview(noContentLabel)
        noContentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.view.leadingAnchor.constraint(equalTo: noContentLabel.leadingAnchor, constant: -10),
            self.view.trailingAnchor.constraint(equalTo: noContentLabel.trailingAnchor, constant: 10),
            self.view.topAnchor.constraint(equalTo: noContentLabel.topAnchor, constant: 10),
            self.view.bottomAnchor.constraint(equalTo: noContentLabel.bottomAnchor, constant: 10),
        ])
        noContentLabel.isHidden = true
        self.noContentLabel = noContentLabel
    }
    
    func updatePhotos(photos: [PhotoViewModel]) {
        self.viewModel.photos = photos
        DispatchQueue.main.async {
            if photos.count > 0 {
                self.collectionView?.isHidden = false
                self.noContentLabel?.isHidden = true
            } else {
                self.collectionView?.isHidden = true
                self.noContentLabel?.isHidden = false
            }
            self.collectionView?.reloadData()
            self.stopProgress()
        }
    }
    
    func showError(error: Error) {
        //Handle error
    }

}

extension SearchViewController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, text.count > 1 else {
            return
        }
        
        self.interactor.getPhotos(searchTerm: text)
        searchBarController?.searchBar.resignFirstResponder()
    }
}

//MARK:- UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.photos.count
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
        
        let model = viewModel.photos[indexPath.row]
        cell.model = model
        self.interactor.downloadImage(imageURL: model.photoURL) { (image) in
            DispatchQueue.main.async {
                if let newImage = image {
                    cell.imageView?.image = newImage
                } else {
                    cell.imageView?.image = UIImage(named: "placeholder")
                }
            }
        }
        
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
