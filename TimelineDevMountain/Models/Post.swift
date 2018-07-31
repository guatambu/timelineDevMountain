//
//  Post.swift
//  TimelineDevMountain
//
//  Created by Michael Guatambu Davis on 7/28/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CloudKit

class Post {
    
    // MARK: - Private Keys
    
    fileprivate let photoDataKey = "photoData"
    fileprivate let timestampKey = "timestamp"
    fileprivate let commentsKey = "comments"
    fileprivate let applePostReferenceKey = "applePostReference"
    
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
    
    // CloudKit Properties
    var ckRecordID: CKRecordID?   // custom Post record ID
    let applePostReference: CKReference // reference to custom iCloud Post
    
    
    // MARK: - Initializers
    
    // memberwise
    init(photoData: Data?, timestamp: Date = Date(), comments: [Comment] = [], applePostReference: CKReference) {
        self.photoData = photoData
        self.timestamp = timestamp
        self.comments = comments
        self.applePostReference = applePostReference
    }
    
    // ckRecord initializer
    init?(ckRecord: CKRecord) {
        guard   let photoData = ckRecord[photoDataKey] as? Data,
                let timestamp = ckRecord[timestampKey] as? Date,
                let comments = ckRecord[commentsKey] as? [Comment],
                let applePostReference = ckRecord[applePostReferenceKey] as? CKReference
            else { return nil }
        
        self.photoData = photoData
        self.timestamp = timestamp
        self.comments = comments
        self.applePostReference = applePostReference
    }
    
}

extension Post: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        let matchingComments = comments.filter { $0.matches(searchTerm: searchTerm) }
        return !matchingComments.isEmpty
    }
}

extension CKRecord {
    
    convenience init(post:Post) {
    
        // Post object's existing userID if present, if none, then create one
        let recordID = post.ckRecordID ?? CKRecordID(recordName: UUID().uuidString)
        
        // designated initializer
        self.init(recordType: "Post", recordID: recordID)
        
        // set values
        self.setValue(post.photoData, forKey: post.photoDataKey)
        self.setValue(post.timestamp, forKey: post.timestampKey)
        self.setValue(post.comments, forKey: post.commentsKey)
        self.setValue(post.applePostReference, forKey: post.applePostReferenceKey)
    }
}























