//
//  Post.swift
//  TimelineDevMountain
//
//  Created by Michael Guatambu Davis on 7/28/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class Post {
    
    // MARK: - Properties
    
    let photoData: Data?
    var timestamp: Date
    var comments: [Comment]
    var photo: UIImage {
        guard   let data = photoData,
                let foto = UIImage(data: data)
            else { return #imageLiteral(resourceName: "post_list") }
        return foto
    }
    
    
    // MARK: - Initializers
    
    // memberwise
    init(photoData: Data?, timestamp: Date = Date(), comments: [Comment] = []) {
        self.photoData = photoData
        self.timestamp = timestamp
        self.comments = comments
    }
    
    
}


extension Post: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        var match: Bool = false
        for comment in self.comments {
            if comment.matches(searchTerm: searchTerm) == true {
                match = true
            }
        }
        return match
    }
}























