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
        let mockPresenter = MockSearchViewPresenter()
        interactor = SearchViewInteractor(service: mockService)
        interactor.presenter = mockPresenter

        interactor.getPhotos(searchTerm: nil)
        XCTAssertTrue(mockService.isGetPhotosCalled)
        XCTAssertTrue(mockPresenter.isUpdatePhotosCalled)
        XCTAssertEqual(mockPresenter.photos?.first?.photoName, "mockTitle")
        XCTAssertEqual(mockPresenter.photos?.first?.photoURL, "https://live.staticflickr.com/Sev1/1_Sec1_w.jpg")
    }
    
    func test_getPhotoFailure() {
        let mockService = MockPhotoService()
        let mockPresenter = MockSearchViewPresenter()
        mockService.mockError = true
        interactor = SearchViewInteractor(service: mockService)
        interactor.presenter = mockPresenter
        
        interactor.getPhotos(searchTerm: nil)
        XCTAssertTrue(mockService.isGetPhotosCalled)
        XCTAssertTrue(mockPresenter.isShowErrorCalled)
    }
    
    func test_downloadImageSuccess() {
        let mockService = MockPhotoService()
        interactor = SearchViewInteractor(service: mockService)
        interactor.downloadImage(imageView: UIImageView(),
                                 imageURL: "mockURL") { image in
                                    XCTAssertNotNil(image)
        }
        XCTAssertTrue(mockService.isDownloadPhotoCalled)
    }
    
    func test_downloadImageFailure() {
        let mockService = MockPhotoService()
        mockService.mockError = true
        interactor = SearchViewInteractor(service: mockService)
        interactor.downloadImage(imageView: UIImageView(),
                                 imageURL: "mockURL") { image in
                                    XCTAssertNil(image)
        }
        XCTAssertTrue(mockService.isDownloadPhotoCalled)
    }
}
