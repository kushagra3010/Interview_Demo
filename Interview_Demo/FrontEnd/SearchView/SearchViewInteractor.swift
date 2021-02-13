//
//  SearchViewInteractor.swift
//  Interview_Demo
//
//  Created by Kushagara on 13/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation

final class SearchViewInteractor: SearchViewIneractorable {
    
    private let service: PhotoServiceInterface
    
    init(service: PhotoServiceInterface) {
        self.service = service
    }
    
    func getPhotos() {
        self.service.getPhotos(searchTerm: "nature") { (photos, error) in
            print("\(photos)")
        }
    }
    
    func getSearchResults(searchTerm: String) {
        
    }
    
    func cancelImageDownload(photo: PhotoViewModel) {
        
    }
    
    
}


