//
//  Created by Jordi Serra i Font on 21/4/17.
//  Copyright © 2017 kudai. All rights reserved.
//

import BSWFoundation
import BSWInterfaceKit
import Deferred

class Wireframe {
    
    let window = UIWindow()
    
    static var shared: Wireframe {
        return (UIApplication.shared.delegate as! AppDelegate).wireframe
    }
    
    init() {
        let rootVC = viewControllerForCurrentState()
        
        /** Style the app */
        AppThemer.themer.themeApp(self.window)
        
        /** Wire up the UIWindow */
        self.window.rootViewController = rootVC
        self.window.makeKeyAndVisible()
    }
    
    fileprivate func viewControllerForCurrentState() -> UIViewController {
        let navigationController = UINavigationController(rootViewController: DisplayViewControllerFactory.displayViewController())
        return navigationController
    }
}
