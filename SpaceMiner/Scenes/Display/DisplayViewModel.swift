//
//  DisplayViewModel.swift
//  SpaceMiner
//
//  Created by Jordi Serra i Font on 20/5/17.
//  Copyright © 2017 kudai. All rights reserved.
//

import Foundation

struct DisplayViewModel {
    let message: String
    let actions: [Action]
    
    struct Action {
        let title: String
        let isEnabled: Bool
    }
}


extension DisplayViewModel.Action {
    init(title: String) {
        self.init(title: title, isEnabled: true)
    }
}
