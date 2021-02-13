
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
}
