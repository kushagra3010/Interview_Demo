//
//  ServiceManagerTests.swift
//  Interview_DemoTests
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import XCTest
@testable import Interview_Demo

class ServiceManagerTests: XCTestCase {
    
    private(set) var serviceManager: ServiceManager!
    private(set) var mockSession: MockUrlSession!
    
    override func setUp() {
        mockSession = MockUrlSession()
    }

    func test_getRequestSucess() {
        
        serviceManager = ServiceManager(session: mockSession)
        
        let data = "mockData".data(using: .utf8)
        mockSession.data = data

        let fileurl = URL(fileURLWithPath: "url")
        
        let request = ServiceRequestModel(request: URLRequest(url: fileurl))
        serviceManager.getRequest(req: request) { (response, error) in
            XCTAssertNotNil(response?.data)
            XCTAssertNil(error)
        }
        XCTAssertTrue(mockSession.isDataTaskCalled)
        XCTAssertTrue(mockSession.mockDataTask?.isResumeMethodCalled ?? false)
        
    }
    
    func test_getRequestFailure() {
        mockSession.mockError = true
        serviceManager = ServiceManager(session: mockSession)

        let fileurl = URL(fileURLWithPath: "url")
        
        let request = ServiceRequestModel(request: URLRequest(url: fileurl))
        serviceManager.getRequest(req: request) { (response, error) in
            XCTAssertNil(response?.data)
            XCTAssertNotNil(error)
        }
        XCTAssertTrue(mockSession.isDataTaskCalled)
        XCTAssertTrue(mockSession.mockDataTask?.isResumeMethodCalled ?? false)
    }
    
    func test_downloadRequestSucess() {
        serviceManager = ServiceManager(session: mockSession)

        let fileurl = URL(fileURLWithPath: "url")
        
        let request = ServiceRequestModel(request: URLRequest(url: fileurl))
        _ = serviceManager.downloadRequest(req: request) { (response, error) in
            XCTAssertNotNil(error)
        }
        XCTAssertTrue(mockSession.isDownloadTaskCalled)
        XCTAssertTrue(mockSession.mockDownloadTask?.isResumeMethodCalled ?? false)
    }
    
    func test_downloadRequestFailure() {
        mockSession.mockError = true
        serviceManager = ServiceManager(session: mockSession)

        let fileurl = URL(fileURLWithPath: "url")
        
        let request = ServiceRequestModel(request: URLRequest(url: fileurl))
        _ = serviceManager.downloadRequest(req: request) { (response, error) in
            XCTAssertNil(response?.data)
            XCTAssertNotNil(error)
        }
        XCTAssertTrue(mockSession.isDownloadTaskCalled)
        XCTAssertTrue(mockSession.mockDownloadTask?.isResumeMethodCalled ?? false)
    }

}
