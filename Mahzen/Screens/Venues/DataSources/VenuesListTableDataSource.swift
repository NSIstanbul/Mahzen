//
//  VenuesListTableDataSource.swift
//  Mahzen
//
//  Created by Said Ozcan on 25/12/2017.
//  Copyright © 2017 SaidOzcan. All rights reserved.
//

import UIKit
import AlamofireImage
import FirebaseAnalytics

class VenuesListTableDataSource: NSObject {
    // MARK: Properties
    private(set) var venues: [Venue] = []
    fileprivate let imageDownloadingManager: ImageDownloadingManager
    
    // MARK: Lifecycle
    init(tableView: UITableView, imageDownloadingManager: ImageDownloadingManager) {
        self.imageDownloadingManager = imageDownloadingManager
        tableView.register(VenueTableViewCell.self, forCellReuseIdentifier: "VenueTableViewCell")
        super.init()
    }
    
    // MARK: Public
    func update(with venues:[Venue]) {
        self.venues = venues
    }
    
    // MARK: Private
    fileprivate func getPhotoURL(for indexPath:IndexPath) -> URL? {
        let venue = venues[indexPath.section]
        return URL(string: venue.photoURLString)
    }
    
    fileprivate func getPhotoURLs(for indexPaths:[IndexPath]) -> [URL] {
        return indexPaths.flatMap({ (indexPath) -> URL? in
            return getPhotoURL(for: indexPath)
        })
    }
}

extension VenuesListTableDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueTableViewCell", for: indexPath) as! VenueTableViewCell
        let venue = venues[indexPath.section]
        cell.configureCell(for: venue)
        if let photoURL = self.getPhotoURL(for: indexPath) {
            cell.photoImageView.af_setImage(withURL: photoURL)
        }
        return cell
    }
}

extension VenuesListTableDataSource: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        imageDownloadingManager.prefetch(getPhotoURLs(for: indexPaths))
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        imageDownloadingManager.cancelPrefetcing(getPhotoURLs(for: indexPaths))
    }
}

extension VenuesListTableDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        Analytics.logEvent(Defines.Analytics.didTapOnVenue, parameters: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Defines.Metrics.Spacings.single / 2
    }
}
