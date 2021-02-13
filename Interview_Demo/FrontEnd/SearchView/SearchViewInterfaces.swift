//
//  SearchViewInterfaces.swift
//  Interview_Demo
//
//  Created by Kushagara on 13/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation

protocol SearchViewControllable: class {
    func updatePhotos(photos: [PhotoViewModel])
}

protocol SearchViewPresentable {
    func updatePhotos(photos: [PhotoViewModel])
    func updateSearchResults(photos: [PhotoViewModel])
}

protocol SearchViewIneractorable {
    func getPhotos()
    func getSearchResults(searchTerm: String)
    func cancelImageDownload(photo: PhotoViewModel)
}
