//
//  VenuesListCollectionViewDataSource.swift
//  Mahzen
//
//  Created by Said Ozcan on 25/12/2017.
//  Copyright © 2017 SaidOzcan. All rights reserved.
//

import UIKit
import FirebaseAnalytics

final class VenuesListCollectionViewDataSource: NSObject {
    
    // MARK: Properties
    private(set) var venues: [Venue] = []
    fileprivate let imageDownloadingManager: ImageDownloadingManager
    
    // MARK: Lifecycle
    init(collectionView: UICollectionView, imageDownloadingManager: ImageDownloadingManager) {
        self.imageDownloadingManager = imageDownloadingManager
        collectionView.register(VenueCollectionViewCell.self, forCellWithReuseIdentifier: "VenueCollectionViewCell")
        super.init()
    }
    
    // MARK: Public
    func update(with venues:[Venue]) {
        self.venues = venues
    }
    
    // MARK: Private
    fileprivate func getPhotoURL(for indexPath:IndexPath) -> URL? {
        let venue = venues[indexPath.row]
        return URL(string: venue.photoURLString)
    }
    
    fileprivate func getPhotoURLs(for indexPaths:[IndexPath]) -> [URL] {
        return indexPaths.flatMap({ (indexPath) -> URL? in
            return getPhotoURL(for: indexPath)
        })
    }
}

extension VenuesListCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VenueCollectionViewCell", for: indexPath) as! VenueCollectionViewCell
        let venue = venues[indexPath.row]
        cell.configureCell(for: venue)
        if let photoURL = self.getPhotoURL(for: indexPath) {
            cell.photoImageView.af_setImage(withURL: photoURL)
        }
        return cell
    }
}

extension VenuesListCollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        Analytics.logEvent(Defines.Analytics.didTapOnVenue, parameters: nil)
    }
}
