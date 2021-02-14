//
//  ServiceManager.swift
//  Interview_Demo
//
//  Created by Kushagara on 13/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation

final class ServiceManager: ServiceManagerInterface {
    
    static let shared = ServiceManager()
    
    private init() {
        //Initialization
    }

    func getRequest(req: ServiceRequestModel, completionBlock: @escaping ((ServiceResponseModel?, Error?) -> Void)) {
        let session = URLSession.shared
        let task = session.dataTask(with: req.request) { (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            let responseModel = ServiceResponseModel(data: data,
                                                     statusCode: httpResponse?.statusCode ?? 0)
            completionBlock(responseModel, error)
        }
        task.resume()
    }
    
    func downloadRequest(req: ServiceRequestModel, completionBlock: @escaping ((ServiceResponseModel?, Error?) -> Void)) -> URLSessionTask {
        let session = URLSession.shared
        let task = session.downloadTask(with: req.request) { (fileUrl, response, error) in
            do {
                guard let url = fileUrl else {
                    completionBlock(nil, NSError(domain: "",
                                                 code: 0,
                                                 userInfo: [NSLocalizedDescriptionKey: ServiceConstants.defaultErrorMessage]))
                    return
                }
                let httpResponse = response as? HTTPURLResponse
                let imageData = try Data(contentsOf: url)
                let responseModel = ServiceResponseModel(data: imageData,
                                                         statusCode: httpResponse?.statusCode ?? 0)
                completionBlock(responseModel, error)
            } catch {
                completionBlock(nil, error)
            }
        }
        task.resume()
        return task
    }
}
