//
//  SearchViewModel.swift
//  Interview_Demo
//
//  Created by Kushagara on 13/02/21.
//  Copyright © 2021 Kushagara. All rights reserved.
//

import Foundation

struct SearchViewModel {
    var photos: [PhotoViewModel]
    let searchTerm: String? = nil
}

struct PhotoViewModel {
    let photoName: String
    let photoURL: String
}
