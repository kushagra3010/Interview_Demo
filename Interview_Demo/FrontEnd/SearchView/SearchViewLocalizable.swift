//
//  SearchViewLocalizable.swift
//  Interview_Demo
//
//  Created by Kushagara on 13/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation

struct SearchViewLocalizeStrings {
    
    var title : String {
        return LocalizationUtilty.localizeString(key: "searchtitle")
    }
    
    var noContentText: String {
        return LocalizationUtilty.localizeString(key: "noContentText")
    }
    
}
