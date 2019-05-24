//
//  ExpandableNames.swift
//  iSpaceLab
//
//  Created by TRANVINHDAT on 5/2/19.
//  Copyright © 2019 Ho Dac Hung. All rights reserved.
//

import Foundation
import Contacts

struct ExpandableNames {
    
    var isExpanded : Bool
    var names : [FavoritableContact]
    
}


struct FavoritableContact {
    let contact: CNContact
    var hasFavorited: Bool
}
