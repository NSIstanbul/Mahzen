//
//  Defines.swift
//  Mahzen
//
//  Created by Said Ozcan on 25/12/2017.
//  Copyright © 2017 SaidOzcan. All rights reserved.
//

import UIKit

enum Defines {
    
    enum Analytics {
        static let didTapOnVenue: String = "user_tapped_venue"
    }
    
    enum Copies {
        enum Venues {
            static let title: String = "Venues"
        }
    }
    
    enum Colors {
        static let gray: UIColor = UIColor.lightGray
        static let white: UIColor = UIColor.white
    }
    
    enum Metrics {
        
        static let cornerRadius: CGFloat = 8.0
        
        enum Spacings {
            static let single: CGFloat = 4.0
            static let double: CGFloat = 16.0
        }
    }
    
    enum Sizes {
        static let defaultVenueTableCellHeight: CGFloat = 350.0
    }
}
