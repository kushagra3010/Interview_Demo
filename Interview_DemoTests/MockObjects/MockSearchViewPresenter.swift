//
//  MockPresenter.swift
//  Interview_DemoTests
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation
@testable import Interview_Demo

final class MockSearchViewPresenter: SearchViewPresentable {
    
    private(set) var isUpdatePhotosCalled: Bool = false
    private(set) var isShowErrorCalled: Bool = false
    
    private(set) var photos: [PhotoViewModel]? = nil
    
    func updatePhotos(photos: [PhotoViewModel]) {
        self.isUpdatePhotosCalled = true
        self.photos = photos
    }
    
    func showError(error: Error) {
        self.isShowErrorCalled = true
    }
    
}

