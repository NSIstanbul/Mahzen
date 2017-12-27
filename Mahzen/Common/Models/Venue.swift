//
//  Venue.swift
//  Mahzen
//
//  Created by Said Ozcan on 25/12/2017.
//  Copyright © 2017 SaidOzcan. All rights reserved.
//

import Unbox

struct Venue {
    let name: String
    let type: String
    let district: String
    let photoURLString: String
    let foursquareID: String
}

extension Venue: Unboxable {
    init(unboxer: Unboxer) throws {
        self.name = try unboxer.unbox(key: "name")
        self.type = try unboxer.unbox(key: "type")
        self.district = try unboxer.unbox(key: "district")
        self.photoURLString = try unboxer.unbox(key: "photo_url")
        self.foursquareID = try unboxer.unbox(key: "foursquare_id")
    }
}
