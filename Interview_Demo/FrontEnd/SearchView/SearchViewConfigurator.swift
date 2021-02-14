//
//  SearchViewConfigurator.swift
//  Interview_Demo
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation
import UIKit

final class SearchViewConfigurator {
    
    func configViewController() -> UIViewController {
        
        let photoService = PhotoServiceManager()
        let interactor = SearchViewInteractor(service: photoService)
        let viewController = SearchViewController(interactor: interactor)
        let presenter = SearchViewPresenter(controller: viewController)
        interactor.presenter = presenter
        
        return viewController
    }
}
