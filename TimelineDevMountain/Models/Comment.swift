//
//  Comment.swift
//  TimelineDevMountain
//
//  Created by Michael Guatambu Davis on 7/28/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation

class Comment {
    
    // MARK: - Properties
    
    var text: String
    var timestamp: Date
    var post: Post
    
    
    // MARK: - Initializers
    
    // memberwise
    init(text: String, timestamp: Date = Date(), post: Post) {
        self.text = text
        self.timestamp = timestamp
        self.post = post
    }
}


extension Comment: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
         return text.lowercased().contains(searchTerm)
    }
}























