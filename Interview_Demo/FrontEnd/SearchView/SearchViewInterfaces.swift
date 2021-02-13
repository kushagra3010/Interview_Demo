//
//  SearchViewInterfaces.swift
//  Interview_Demo
//
//  Created by Kushagara on 13/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation

protocol SearchViewControllable {
    func updatePhotos(photos: [PhotoViewModel])
}

protocol SearchViewPresentable {
    func updatePhotos(photos: [PhotoModel])
    func updateSearchResults(photos: [PhotoModel])
}

protocol SearchViewIneractorable {
    func getPhotos()
    func getSearchResults(searchTerm: String)
    func cancelImageDownload(photo: PhotoViewModel)
}
