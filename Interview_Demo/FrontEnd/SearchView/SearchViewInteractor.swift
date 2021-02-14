//
//  SearchViewInteractor.swift
//  Interview_Demo
//
//  Created by Kushagara on 13/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation
import UIKit

final class SearchViewInteractor: SearchViewIneractorable {
    
    private let service: PhotoServiceInterface
    var presenter: SearchViewPresentable?
    
    init(service: PhotoServiceInterface) {
        self.service = service
    }
    
    func getPhotos(searchTerm: String?) {
        self.service.getPhotos(searchTerm: searchTerm ?? "nature") { (photos, error) in
            
            if let newError = error {
                self.presenter?.showError(error: newError)
            } else {
                let photosVMs = photos?.map({ (model) -> PhotoViewModel in
                    PhotoViewModel(photoName: model.title, photoURL: model.photoImageUrl)
                })
                self.presenter?.updatePhotos(photos: photosVMs ?? [])
            }
        }
    }
    
    func downloadImage(imageURL: String, callBack: @escaping ((_ image: UIImage?) -> Void)) {
        
        self.service.downloadPhoto(photoURL: imageURL) { (image, error) in
            if let _ = error {
                callBack(nil)
            } else {
                callBack(image)
            }
            
        }
    }
    
    func cancelImageDownload(photo: PhotoViewModel) {
        
    }
    
    
}


