//
//  SearchViewInteractorTests.swift
//  Interview_DemoTests
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import XCTest
@testable import Interview_Demo

class SearchViewInteractorTests: XCTestCase {

    private(set) var interactor: SearchViewInteractor!
    
    func test_getPhotoSuccess() {
        let mockService = MockPhotoService()
        interactor = SearchViewInteractor(service: mockService)
        interactor.getPhotos(searchTerm: nil)
        XCTAssertTrue(mockService.isGetPhotosCalled)
    }
    
    func test_getPhotoFailure() {
        let mockService = MockPhotoService()
        mockService.mockError = true
        interactor = SearchViewInteractor(service: mockService)
        interactor.getPhotos(searchTerm: nil)
        XCTAssertTrue(mockService.isGetPhotosCalled)
    }
    
    func test_downloadImageSuccess() {
        let mockService = MockPhotoService()
        interactor = SearchViewInteractor(service: mockService)
        interactor.downloadImage(imageView: UIImageView(),
                                 imageURL: "mockURL") { image in
        }
        XCTAssertTrue(mockService.isDownloadPhotoCalled)
    }
    
    func test_downloadImageFailure() {
        let mockService = MockPhotoService()
        interactor = SearchViewInteractor(service: mockService)
        interactor.downloadImage(imageView: UIImageView(),
                                 imageURL: "mockURL") { image in
        }
        XCTAssertTrue(mockService.isDownloadPhotoCalled)
    }
}
