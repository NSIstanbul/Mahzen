//
//  RemoteConfigManager.swift
//  Mahzen
//
//  Created by Said Ozcan on 23/12/2017.
//  Copyright © 2017 SaidOzcan. All rights reserved.
//

import Foundation
import Firebase

extension RemoteConfigFetchStatus {
    var debugDescription: String {
        switch self {
        case .failure:
            return "failure"
        case .noFetchYet:
            return "pending"
        case .success:
            return "success"
        case .throttled:
            return "throttled"
        }
    }
}

enum RemoteConfigKey: String {
    case venuesListTitle = "venues_list_title"
    case venuesListStyle = "venuest_list_style"
}

class RemoteConfigManager: NSObject {
    
    // MARK: Properties
    let remoteConfig: RemoteConfig
    fileprivate var expirationDuration: Double = 3600
    
    // MARK: Lifecycle
    override init() {
        FirebaseApp.configure()
        self.remoteConfig = RemoteConfig.remoteConfig()
        print("Firebase Instance Token: \(InstanceID.instanceID().token())")
        super.init()
    }
    
    // MARK: Public
    func setup(completionHandler: @escaping () -> Void) {
        self.configureDefaults()
        self.configureSettings()
        self.fetchRemoteValues(completionHandler: completionHandler)
    }
    
    func parameterValue(for key: String) -> String? {
        return remoteConfig[key].stringValue
    }
    
    // MARK: Private
    fileprivate func configureDefaults() {
        let defaultValues: [String: String] = [
            RemoteConfigKey.venuesListTitle.rawValue: "Venues",
            RemoteConfigKey.venuesListStyle.rawValue: "list"
        ]
        remoteConfig.setDefaults(defaultValues as [String : NSObject])
    }
    
    fileprivate func configureSettings() {
        if let remoteConfigSettings = RemoteConfigSettings(developerModeEnabled: true) {
            remoteConfig.configSettings = remoteConfigSettings
        }

        if remoteConfig.configSettings.isDeveloperModeEnabled {
            expirationDuration = 0
        }
    }
    
    fileprivate func fetchRemoteValues(completionHandler: @escaping () -> Void) {
        remoteConfig.fetch(withExpirationDuration: expirationDuration) { (status, error) in
            print("Fetched from remote")
            if error == nil {
                RemoteConfig.remoteConfig().activateFetched()
            } else {
                print(error?.localizedDescription)
                print(status.debugDescription)
            }
            completionHandler()
        }
    }
}
