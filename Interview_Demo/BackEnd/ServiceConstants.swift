
//
//  ServiceConstants.swift
//  Interview_Demo
//
//  Created by Kushagara on 13/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation

enum AppEnvironment: String {
    case Dev
    case Mock
}

final class ServiceConstants {
    static let currentEnvironment : AppEnvironment = .Dev
    
    static let apiKey = "e69b9fa4f366059007461367a7546a7e"
    static let searchURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(ServiceConstants.apiKey)&format=json&nojsoncallback=1&safe_search=1&text=%@"
    
    static let defaultErrorMessage = "Something went wrong, please try again"
}
