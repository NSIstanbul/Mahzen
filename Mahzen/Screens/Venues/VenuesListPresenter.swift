//
//  VenuesListPresenter.swift
//  Mahzen
//
//  Created by Said Ozcan on 25/12/2017.
//  Copyright © 2017 SaidOzcan. All rights reserved.
//

import UIKit

final class VenuesListPresenter: NSObject {
    // MARK: Properties
    fileprivate let dataManager: DataManager
    weak var view: VenuesListController?
    
    // MARK: Lifecycle
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        super.init()
    }
    
    // MARK: Public
    func fetchVenues() {
        dataManager.fetchVenues { [weak self] result in
            switch result {
            case .success(let venues):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self?.view?.show(venues: venues)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
