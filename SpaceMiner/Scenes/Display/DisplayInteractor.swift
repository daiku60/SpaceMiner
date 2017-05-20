//
//  DisplayInteractor.swift
//  SpaceMiner
//
//  Created by Jordi Serra i Font on 20/5/17.
//  Copyright © 2017 kudai. All rights reserved.
//

import Foundation
import Deferred

protocol DisplayInteractorType {
    func retrieveDisplayData() -> Task<DisplayViewModel>
}

class DisplayInteractor: DisplayInteractorType {
    func retrieveDisplayData() -> Task<DisplayViewModel> {
        return Task(success: .planet)
    }
}
