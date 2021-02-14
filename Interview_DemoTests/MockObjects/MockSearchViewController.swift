//
//  MockSearchViewController.swift
//  Interview_DemoTests
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation
@testable import Interview_Demo

final class MockSearchViewController: SearchViewControllable {
    
    private(set) var isUpdatePhotosCalled: Bool = false
    private(set) var isShowErrorCalled: Bool = false
    
    func updatePhotos(photos: [PhotoViewModel]) {
        self.isUpdatePhotosCalled = true
    }
    
    func showError(error: Error) {
        self.isShowErrorCalled = true
    }
}
