//
//  PhotoServiceManager.swift
//  Interview_Demo
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation
import UIKit

final class PhotoServiceManager : PhotoServiceInterface {
    
    private let serviceManager: ServiceManagerInterface
    
    init(serviceManager: ServiceManagerInterface = ServiceManager.shared) {
        self.serviceManager = serviceManager
    }
    
    func getPhotos(searchTerm: String, completionBlock: @escaping ((_ photos: [PhotoModel]?, _ error: Error?) -> Void)) {
        
        let serviceURL = String(format: ServiceConstants.searchURL, searchTerm)
        guard let url = URL(string: serviceURL) else {
            completionBlock(nil, NSError(domain: "",
                                         code: 0,
                                         userInfo: [NSLocalizedDescriptionKey: ServiceConstants.defaultErrorMessage]))
            return
        }
        let request = URLRequest(url: url)
        
        let serviceReq = ServiceRequestModel(request: request)
        self.serviceManager.getRequest(req: serviceReq) { (response, error) in
            
            do {
                if let responseData = response?.data {
                    let searchResult = try JSONDecoder().decode(SearchResultModel.self, from: responseData)
                    completionBlock(searchResult.photos?.photo ?? [],error)
                } else {
                    completionBlock(nil, error)
                }
            } catch {
                completionBlock(nil, error)
            }
        }
    }
    
    func downloadPhoto(photo: PhotoModel, completionBlock: @escaping ((_ image: UIImage?, _ error: Error?) -> Void)) {
        
    }
}
