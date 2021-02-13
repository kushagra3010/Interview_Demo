//
//  PhotoModel.swift
//  Interview_Demo
//
//  Created by Kushagara on 13/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation

struct PhotoModel: Codable {
    let id : String
    let secret : String
    let server: String
    let title: String
    let photoImageUrl: String?
}
