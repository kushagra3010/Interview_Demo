//
//  MockPhotoCacheManager.swift
//  Interview_DemoTests
//
//  Created by Kushagara on 15/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation
import UIKit
@testable import Interview_Demo

final class MockPhotoCacheManager: PhotoCachingManagerInterface {
    
    private(set) var isGetImageCalled: Bool = false
    private(set) var isSaveImageCalled: Bool = false
    
    var imageKey: String? = nil
    private(set) var imageDictionary = ["cacheKey": UIImage()]
    
    func getImage(key: String) -> UIImage? {
        self.isGetImageCalled = true
        let image = self.imageDictionary[key]
        return image
    }
    
    func saveImage(image: UIImage, forKey key: String) {
        self.isSaveImageCalled = true
    }
}
