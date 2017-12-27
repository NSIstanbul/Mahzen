//
//  RoutingManager.swift
//  Mahzen
//
//  Created by Said Ozcan on 25/12/2017.
//  Copyright © 2017 SaidOzcan. All rights reserved.
//

import UIKit

final class RoutingManager: NSObject {
    // MARK: Properties
    fileprivate let window: UIWindow
    
    // MARK: Lifecycle
    init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    // MARK: Public
    func showVenuesList(imageDownloadingManager: ImageDownloadingManager, remoteConfigManager: RemoteConfigManager) {
        let dataManager = DataManager()
        
        let presenter = VenuesListPresenter(dataManager: dataManager)
        let view = VenuesListController(presenter: presenter, imageDownloadingManager: imageDownloadingManager, remoteConfigManager: remoteConfigManager)
        presenter.view = view
        
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.navigationBar.prefersLargeTitles = true
        window.rootViewController = navigationController
    }
}
