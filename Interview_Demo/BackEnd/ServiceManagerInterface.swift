//
//  ServiceManagerInterface.swift
//  Interview_Demo
//
//  Created by Kushagara on 13/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation

struct ServiceRequestModel {
    let request: URLRequest
}

struct ServiceResponseModel {
    let data: Data?
    let statusCode: Int
}

protocol ServiceManagerInterface {
    
    func getRequest(req: ServiceRequestModel , completionBlock: @escaping ((_ res: ServiceResponseModel?, _ error: Error?) -> Void))
    
    func downloadRequest(req: ServiceRequestModel, completionBlock: @escaping ((_ res: ServiceResponseModel?, _ error: Error?) -> Void))
    
}
