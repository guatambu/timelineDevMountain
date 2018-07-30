//
//  SearchableRecord.swift
//  TimelineDevMountain
//
//  Created by Kelly Johnson on 7/30/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation

protocol SearchableRecord {
    func matches(searchTerm: String) -> Bool
    
}




