//
//  AppDelegate.swift
//  Mahzen
//
//  Created by Said Ozcan on 23/12/2017.
//  Copyright © 2017 SaidOzcan. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Properties
    var window: UIWindow?

    // MARK: Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }
        
        setup(window: window)
        
        let imageDownloadingManager = ImageDownloadingManager()
        
        let remoteConfigManager = RemoteConfigManager()
        let routingManager = RoutingManager(window: window)
        routingManager.showLoadingScreen()
        remoteConfigManager.setup {
            routingManager.showVenuesList(imageDownloadingManager: imageDownloadingManager, remoteConfigManager: remoteConfigManager)
        }
        return true
    }
    
    // MARK: Private
    fileprivate func setup(window: UIWindow) {
        window.backgroundColor = UIColor.black
        window.makeKeyAndVisible()
        window.rootViewController = UIViewController()
    }
}

