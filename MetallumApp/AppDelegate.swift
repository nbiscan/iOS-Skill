//
//  AppDelegate.swift
//  MetallumApp
//
//  Created by Five on 10/04/2017.
//  Copyright © 2017 Five. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let dataStore = DataStore()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame : UIScreen.main.bounds)
        
        let viewController = HomeViewController()
        let nc = UINavigationController(rootViewController : viewController)
        
        nc.navigationBar.barStyle = .blackTranslucent
        
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

