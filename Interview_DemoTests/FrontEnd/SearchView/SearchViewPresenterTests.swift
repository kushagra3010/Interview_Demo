//
//  SearchViewPresenterTests.swift
//  Interview_DemoTests
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import XCTest
@testable import Interview_Demo

class SearchViewPresenterTests: XCTestCase {

    private(set) var presenter: SearchViewPresenter!
    
    func test_updatePhotos() {
        let mockController = MockSearchViewController()
        presenter = SearchViewPresenter(controller: mockController)
        
        presenter.updatePhotos(photos: [])
        
        XCTAssertTrue(mockController.isUpdatePhotosCalled)
    }
    
    func test_showError() {
        let mockController = MockSearchViewController()
        presenter = SearchViewPresenter(controller: mockController)
        
        presenter.showError(error: NSError(domain: "",
                                           code: 0,
                                           userInfo: nil))
        XCTAssertTrue(mockController.isShowErrorCalled)        
    }

}
