//
//  MockServiceManager.swift
//  Interview_DemoTests
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation
import UIKit
@testable import Interview_Demo

final class MockServiceManager: ServiceManagerInterface {
    
    private(set) var isGetRequestCalled: Bool = false
    private(set) var isDownloadReqCalled: Bool = false
    
    var mockError: Bool = false
    
    func getRequest(req: ServiceRequestModel, completionBlock: @escaping ((ServiceResponseModel?, Error?) -> Void)) {
        self.isGetRequestCalled = true
        
        if mockError {
            let error = NSError(domain: "",
                                code: 0, userInfo: [NSLocalizedDescriptionKey: "mockError"])
            completionBlock(nil, error)
        } else {
            let photo = PhotoModel(id: "1",
                                   secret: "Sec1",
                                   server: "Sev1",
                                   title: "title")
            let mockSearchResultPhoto = SearchResultPhotos(page: 1,
                                                           pages: 10,
                                                           perpage: 100,
                                                           photo: [photo],
                                                           total: "2000")
            let mockPhotos = SearchResultModel(stat: "state",
                                               photos: mockSearchResultPhoto)
            
            let data = try? JSONEncoder().encode(mockPhotos)
            
            let mockresponse = ServiceResponseModel(data: data, statusCode: 0)
            completionBlock(mockresponse, nil)
        }
    }
    
    func downloadRequest(req: ServiceRequestModel, completionBlock: @escaping ((ServiceResponseModel?, Error?) -> Void)) -> URLSessionTask {
        self.isDownloadReqCalled = true
        let mockTask = URLSession.shared.dataTask(with: URLRequest(url: URL(fileURLWithPath: "")))
        
        
        if mockError {
            let error = NSError(domain: "",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Mock error"])
            completionBlock(nil, error)
        } else {
            let data = UIImage(named: "placeholder")?.pngData()
            let responseModel = ServiceResponseModel(data: data, statusCode: 0)
            completionBlock(responseModel, nil)
        }
        
        return mockTask
    }
}
