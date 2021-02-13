//
//  SearchResultModel.swift
//  Interview_Demo
//
//  Created by Kushagara on 14/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation

struct SearchResultPhotos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let photo: [PhotoModel]
    let total: String
}

struct SearchResultModel: Codable {
    let stat: String?
    let photos: SearchResultPhotos?
}
