//
//  Comment.swift
//  TimelineDevMountain
//
//  Created by Michael Guatambu Davis on 7/28/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import Foundation
import CloudKit

class Comment {
    
    // MARK: - Private Keys
    
    fileprivate let commentKey = "Comment"
    fileprivate let textKey = "text"
    fileprivate let timestampKey = "timestamp"
    fileprivate let postKey = "post"
    fileprivate let appleUserReferenceKey = "appleUserReference"
    
    
    // MARK: - Properties
    
    var text: String
    var timestamp: Date
    var post: Post
    var ckRecordID: CKRecordID?
    let appleUserReference: CKReference
    
    
    // MARK: - Initializers
    
    // memberwise
    init(text: String, timestamp: Date = Date(), post: Post, appleUserReference: CKReference) {
        self.text = text
        self.timestamp = timestamp
        self.post = post
        self.appleUserReference = appleUserReference
    }
    
    // failable initializer - fetching from cloud
    init?(ckRecord: CKRecord) {
        guard   let text = ckRecord[textKey] as? String,
                let timestamp = ckRecord[timestampKey] as? Date,
                let post = ckRecord[postKey] as? Post,
                let appleUserReference = ckRecord[appleUserReferenceKey] as? CKReference
            else { return nil }
        
        self.text = text
        self.timestamp = timestamp
        self.post = post
        self.appleUserReference = appleUserReference
    }
}


extension Comment: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
         return text.lowercased().contains(searchTerm)
    }
}


extension CKRecord {
    
    convenience init(comment: Comment) {
        
        // Comment object's existing userID if present, if none, then create one
        let recordID = comment.ckRecordID ?? CKRecordID(recordName: UUID().uuidString)
        
        // designated initializer
        self.init(recordType: comment.commentKey, recordID: recordID)
        
        // set values
        self.setValue(comment.text, forKey: comment.textKey)
        self.setValue(comment.timestamp, forKey: comment.timestampKey)
        self.setValue(comment.post, forKey: comment.postKey)
        self.setValue(comment.appleUserReference, forKey: comment.appleUserReferenceKey)
    }
}






















