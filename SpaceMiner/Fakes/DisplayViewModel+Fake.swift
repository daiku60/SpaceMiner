//
//  DisplayViewModel+Fake.swift
//  SpaceMiner
//
//  Created by Jordi Serra i Font on 22/4/17.
//  Copyright © 2017 kudai. All rights reserved.
//

import Foundation
import BSWFoundation

extension DisplayViewModel {
    public static var planet: DisplayViewModel {
        return DisplayViewModel(message: "You are now in the planet", actions: [
            DisplayViewModel.Action(title: "BUY"),
            DisplayViewModel.Action(title: "SELL"),
            DisplayViewModel.Action(title: "DEPART"),
            ])
    }
}
