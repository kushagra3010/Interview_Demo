//
//  SearchViewInterfaces.swift
//  Interview_Demo
//
//  Created by Kushagara on 13/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation
import UIKit

protocol SearchViewControllable: class {
    func updatePhotos(photos: [PhotoViewModel])
    func showError(error: Error)
}

protocol SearchViewPresentable {
    func updatePhotos(photos: [PhotoViewModel])
    func updateSearchResults(photos: [PhotoViewModel])
    func showError(error: Error)
}

protocol SearchViewIneractorable {
    func getPhotos(searchTerm: String?)
    func downloadImage(imageView: UIImageView,
                       imageURL: String,
                       callBack: @escaping ((_ image: UIImage?) -> Void))
}
