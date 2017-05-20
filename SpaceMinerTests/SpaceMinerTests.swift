//
//  SpaceMinerTests.swift
//  SpaceMinerTests
//
//  Created by Jordi Serra i Font on 21/4/17.
//  Copyright © 2017 kudai. All rights reserved.
//

import XCTest
import Deferred
@testable import SpaceMiner

private class DisplayInteractorFake: DisplayInteractorType {
    func retrieveDisplayData() -> Task<DisplayViewModel> {
        return Task(success: .planet)
    }
}

class DisplayTests: SnapshotTestCase {
    
    func testSnapshotDisplayViewController() {
        let vc = DisplayViewController()
        vc.interactor = DisplayInteractorFake()
        debugViewController(UINavigationController(rootViewController: vc))
    }
    
}
