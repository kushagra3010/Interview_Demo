//
//  SearchPresenter.swift
//  Interview_Demo
//
//  Created by Kushagara on 13/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation

final class SearchViewPresenter: SearchViewPresentable {
    
    unowned let viewController: SearchViewControllable
    
    init(controller: SearchViewControllable) {
        self.viewController = controller
    }
    
    func updatePhotos(photos: [PhotoViewModel]) {
        self.viewController.updatePhotos(photos: photos)
    }
    
    func updateSearchResults(photos: [PhotoViewModel]) {
        self.viewController.updatePhotos(photos: photos)
    }
    
    func showError(error: Error) {
        self.viewController.showError(error: error)
    }
    
}

