//
//  PhotoServiceInterface.swift
//  Interview_Demo
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoServiceInterface {
    
    func getPhotos(searchTerm: String, completionBlock: @escaping ((_ photos: [PhotoModel]?, _ error: Error?) -> Void))
    func downloadPhoto(imageView: UIImageView,
                       photoURL: String,
                       completionBlock: @escaping ((_ image: UIImage?, _ error: Error?) -> Void))
}
