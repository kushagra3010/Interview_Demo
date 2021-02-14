//
//  MockURLSession.swift
//  Interview_DemoTests
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation
@testable import Interview_Demo

final class MockURLSessionDataTask: URLSessionDataTask {
    
    private let callBack: () -> Void
    private(set) var isResumeMethodCalled: Bool = false
    
    init(callBack: @escaping () -> Void) {
        self.callBack = callBack
    }

    override func resume() {
        self.isResumeMethodCalled = true
        callBack()
    }
}

final class MockURLSessionDownloadTask: URLSessionDownloadTask {
    
    private let callBack: () -> Void
    private(set) var isResumeMethodCalled: Bool = false
    
    init(callBack: @escaping () -> Void) {
        self.callBack = callBack
    }

    override func resume() {
        self.isResumeMethodCalled = true
        callBack()
    }
}

final class MockUrlSession: URLSession {
 
    private(set) var isDataTaskCalled: Bool = false
    private(set) var isDownloadTaskCalled: Bool = false
    private(set) var mockDataTask: MockURLSessionDataTask?
    private(set) var mockDownloadTask: MockURLSessionDownloadTask?
    
    var mockError: Bool = false
    var data: Data?
    var error: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.isDataTaskCalled = true

        if mockError {
            let error = NSError(domain: "",
                                code: 0, userInfo: [NSLocalizedDescriptionKey: "MockError"])
            let mockDataTask = MockURLSessionDataTask {
                completionHandler(nil, nil, error)
            }
            self.mockDataTask = mockDataTask
            return mockDataTask
        } else {
            let data = self.data
            let mockDataTask = MockURLSessionDataTask {
                completionHandler(data, nil, nil)
            }
            self.mockDataTask = mockDataTask
            return mockDataTask
        }
    }
    
    override func downloadTask(with request: URLRequest, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask {
        self.isDownloadTaskCalled = true

        if mockError {
            let error = NSError(domain: "",
                                code: 0, userInfo: [NSLocalizedDescriptionKey: "MockError"])
            let mockDownloadTask = MockURLSessionDownloadTask {
                completionHandler(nil, nil, error)
            }
            self.mockDownloadTask = mockDownloadTask
            return mockDownloadTask
        } else {
            let mockURL = URL(fileURLWithPath: "MockURLSessionDownloadTask")
            let mockDownloadTask = MockURLSessionDownloadTask {
                completionHandler(mockURL, nil, nil)
            }
            self.mockDownloadTask = mockDownloadTask
            return mockDownloadTask
        }
    }
}
