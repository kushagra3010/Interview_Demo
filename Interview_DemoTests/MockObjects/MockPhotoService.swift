//
//  MockPhotoService.swift
//  Interview_DemoTests
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation
import UIKit
@testable import Interview_Demo

final class MockPhotoService : PhotoServiceInterface {
    
    private(set) var isGetPhotosCalled: Bool = false
    private(set) var isDownloadPhotoCalled: Bool = false
    
    var mockError: Bool = false
    
    func getPhotos(searchTerm: String, completionBlock: @escaping (([PhotoModel]?, Error?) -> Void)) {
        self.isGetPhotosCalled = true
        if mockError {
            let error = NSError(domain: "",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "This is mock error"])
            completionBlock(nil, error)
        } else {
            let mockPhotos = [PhotoModel(id: "1",
                                         secret: "Sec1",
                                         server: "Sev1",
                                         title: "mockTitle")]
            completionBlock(mockPhotos, nil)
        }
    }
    
    func downloadPhoto(imageView: UIImageView, photoURL: String, completionBlock: @escaping ((UIImage?, Error?) -> Void)) {
        self.isDownloadPhotoCalled = true
        
        if mockError {
            let error = NSError(domain: "",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "This is mock error"])
            completionBlock(nil, error)
        } else {
            completionBlock(UIImage(), nil)
        }
    }
}
