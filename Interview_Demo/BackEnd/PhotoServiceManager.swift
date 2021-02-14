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
    private let imageCacheManager: PhotoCachingManagerInterface
    private(set) var imageViewToTask: [UIImageView: (url: String,task: URLSessionTask)] = [:]
    private let imageDictionaryLock = NSLock()
    
    init(serviceManager: ServiceManagerInterface = ServiceManager.shared,
         cacheManager: PhotoCachingManagerInterface = PhotoCachingManager.shared) {
        self.serviceManager = serviceManager
        self.imageCacheManager = cacheManager
    }
    
    func getPhotos(searchTerm: String, completionBlock: @escaping ((_ photos: [PhotoModel]?, _ error: Error?) -> Void)) {

        let encodedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
        let serviceURL = String(format: ServiceConstants.searchURL, encodedSearchTerm)
        guard
            let url = URL(string: serviceURL) else {
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
    
    func downloadPhoto(imageView: UIImageView,
                       photoURL: String,
                       completionBlock: @escaping ((_ image: UIImage?, _ error: Error?) -> Void)) {
        
        guard let cachedImage = self.imageCacheManager.getImage(key: photoURL) else {
            
            guard let url = URL(string: photoURL) else {
                completionBlock(nil, NSError(domain: "",
                                             code: 0,
                                             userInfo: [NSLocalizedDescriptionKey: ServiceConstants.defaultErrorMessage]))
                return
            }
            let request = URLRequest(url: url)
            let serReq = ServiceRequestModel(request: request)
            if !checkIfTaskExists(imageView: imageView, url: photoURL) {
                let downloadTask = self.serviceManager.downloadRequest(req: serReq) { (response, error) in
                    self.removeImageViewTasks(imageView: imageView)
                    if let responseData = response?.data,
                        let image = UIImage(data: responseData){
                        self.imageCacheManager.saveImage(image: image, forKey: photoURL)
                        completionBlock(image,error)
                    } else {
                        completionBlock(nil, error)
                    }
                }
                self.addImageViewTasks(imageView: imageView, touple: (photoURL,downloadTask))
            }
            return
        }
        if let touple = self.imageViewToTask[imageView] {
            touple.task.cancel()
            self.removeImageViewTasks(imageView: imageView)
        }
        completionBlock(cachedImage, nil)
    }
    
    private func removeImageViewTasks(imageView: UIImageView) {
        
        imageDictionaryLock.lock()
        self.imageViewToTask.removeValue(forKey: imageView)
        imageDictionaryLock.unlock()
    }
    
    private func addImageViewTasks(imageView: UIImageView, touple: (url: String,task: URLSessionTask)) {
        
        imageDictionaryLock.lock()
        self.imageViewToTask[imageView] = touple
        imageDictionaryLock.unlock()
    }
    
    private func getImageViewTask(imageView: UIImageView) -> (url: String,task: URLSessionTask)? {
        
        imageDictionaryLock.lock()
        let touple = self.imageViewToTask[imageView]
        imageDictionaryLock.unlock()
        return touple
        
    }
    
    private func checkIfTaskExists(imageView: UIImageView, url: String) -> Bool {
        let touple = self.getImageViewTask(imageView: imageView)
        if touple?.url == url {
            return true
        } else {
            return false
        }
    }
}
