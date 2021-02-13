//
//  LocalizationUtilty.swift
//  Interview_Demo
//
//  Created by Kushagara on 13/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation


struct LocalizationUtilty {
    
    static func localizeString(key: String) -> String {
        return NSLocalizedString(key,
                                 tableName: "Localization",
                                 bundle: Bundle.main,
                                 value: "",
                                 comment: "")
    }
    
}
