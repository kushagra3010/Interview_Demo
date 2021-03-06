//
//  PhotoServiceManagerTests.swift
//  Interview_DemoTests
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import XCTest
@testable import Interview_Demo

class PhotoServiceManagerTests: XCTestCase {

    private(set) var photoServiceManger: PhotoServiceManager!

    func test_getPhotoSucess() {
        
        let mockServiceManager = MockServiceManager()
        photoServiceManger = PhotoServiceManager(serviceManager: mockServiceManager)
        
        photoServiceManger.getPhotos(searchTerm: "test") { (photos, error) in
            XCTAssertEqual(photos?.count, 1)
        }
        
        XCTAssertTrue(mockServiceManager.isGetRequestCalled)
        
    }
    
    func test_getPhotoFailure() {
        let mockServiceManager = MockServiceManager()
        mockServiceManager.mockError = true
        photoServiceManger = PhotoServiceManager(serviceManager: mockServiceManager)
        
        photoServiceManger.getPhotos(searchTerm: "test") { (photos, error) in
            XCTAssertNotNil(error)
        }
        
        XCTAssertTrue(mockServiceManager.isGetRequestCalled)
    }
    
    func test_downloadPhotoSucess() {
        let mockServiceManager = MockServiceManager()
        photoServiceManger = PhotoServiceManager(serviceManager: mockServiceManager)
        
        photoServiceManger.downloadPhoto(imageView: UIImageView(),
                                         photoURL: "photoURL") { (image, error) in
            XCTAssertNotNil(image)
        }
        
        XCTAssertTrue(mockServiceManager.isDownloadReqCalled)
    }
    
    func test_downloadPhotoWithCache() {
        let mockServiceManager = MockServiceManager()
        let mockCache = MockPhotoCacheManager()
        photoServiceManger = PhotoServiceManager(serviceManager: mockServiceManager,
                                                 cacheManager: mockCache)
        
        photoServiceManger.downloadPhoto(imageView: UIImageView(),
                                         photoURL: "cacheKey") { (image, error) in
                                            XCTAssertNotNil(image)
                                            XCTAssertNil(error)
        }
        
        XCTAssertTrue(mockCache.isGetImageCalled)
    }
    
    func test_downloadPhotoCheckIfExists() {
        let mockServiceManager = MockServiceManager()
        let mockCache = MockPhotoCacheManager()
        let mockImageView = UIImageView()
        photoServiceManger = PhotoServiceManager(serviceManager: mockServiceManager,
                                                 cacheManager: mockCache)
        
        photoServiceManger.downloadPhoto(imageView: mockImageView,
                                         photoURL: "photoURL") { (image, error) in
                                            XCTAssertNotNil(image)
                                            XCTAssertNil(error)
        }
        
        var callBackCounter = 0
        photoServiceManger.downloadPhoto(imageView: mockImageView,
                                         photoURL: "photoURL") { (image, error) in
                                            callBackCounter += 1
        }
        XCTAssertEqual(callBackCounter, 0)
    }
    
    func test_downloadPhotoFailure() {
        let mockServiceManager = MockServiceManager()
        mockServiceManager.mockError = true
        photoServiceManger = PhotoServiceManager(serviceManager: mockServiceManager)
        
        photoServiceManger.downloadPhoto(imageView: UIImageView(),
                                         photoURL: "photoURL") { (image, error) in
                XCTAssertNotNil(error)
        }
        
        XCTAssertTrue(mockServiceManager.isDownloadReqCalled)
    }

}
