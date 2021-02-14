//
//  PhotoCachingManager.swift
//  Interview_Demo
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation
import UIKit

final class PhotoCachingManager {
    
    static let shared = PhotoCachingManager()
    private(set) var cache: NSCache<AnyObject,AnyObject> = NSCache()
    
    private init() {
        //Initializer
    }
    
    func getImage(key: String) -> UIImage? {
        
        if let object = self.cache.object(forKey: key as AnyObject) {
            return object as? UIImage
        } else {
            return nil
        }
    }
    
    func saveImage(image: UIImage, forKey key: String) {
        self.cache.setObject(image as AnyObject, forKey: key as AnyObject)
    }
    
    func flushCache() {
        self.cache.removeAllObjects()
    }
}
