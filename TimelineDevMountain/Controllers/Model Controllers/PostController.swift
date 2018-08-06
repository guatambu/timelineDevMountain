//
//  PostController.swift
//  TimelineDevMountain
//
//  Created by Michael Guatambu Davis on 7/28/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CloudKit

class PostController {
    
    // CloudKit order of operations
        // on app launch
            // fetch changes from cloud via cloudKit
            // subscribe to future changes
                // track changes in data and have server let our app know
        // on push from cloudkit
            // fetch changes
    
    
    
    
    // MARK: - Properties
    
    static let shared = PostController()
    
    var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                let notificationCenter = NotificationCenter.default
                notificationCenter.post(name: PostController.PostsChangedNotification, object: self)
            }
        }
    }
    
    let ckPublicDatabase = CKContainer.default().publicCloudDatabase

    
    // MARK: - CRUD Functions (Create, Read, Update, Delete)
    
    
    // Create
    
    func createPostWith(image: UIImage, caption: String, completion: @escaping(_ success: Bool) -> Void) {
        
        CKContainer.default().fetchUserRecordID { (appleUserReferenceID, error) in
            
            if let error = error {
                print("Error creating Post object > PostController.swift line 39 \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let appleUserReferenceID = appleUserReferenceID else {
                completion(false)
                return
            }
            
            let appleUserReference = CKReference(recordID: appleUserReferenceID, action: CKReferenceAction.deleteSelf)
            
            let post = Post(photoData: image.jpeg, timestamp: Date(), comments: [], appleUserReference: appleUserReference)
            
            let comment = Comment(text: caption, post: post, appleUserReference: appleUserReference)
            
            let postRecord = CKRecord(post: post)
            let commentRecord = CKRecord(comment: comment)
            
            self.ckPublicDatabase.save(postRecord) { (postRecord, error) in
                
                if let error = error {
                    print("Error saving Post > PostController.swift line 62 \(error) \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                guard let postRecord = postRecord else {
                    completion(false)
                    return
                }
                
                self.ckPublicDatabase.save(commentRecord) { (commentRecord, error) in
                    
                    if let error = error {
                        print("Error saving Comment > PostController.swift line 75 \(error) \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    
                    guard let commentRecord = commentRecord else {
                        completion(false)
                        return
                    }
                    
                    guard let comment = Comment(ckRecord: commentRecord) else { return }
                    
                    post.comments.append(comment)
                    
                    completion(true)
                }
                
                guard let post = Post(ckRecord: postRecord) else { return }
                
                self.posts.append(post)
                
                completion(true)
            }
        }
    }
    
    // addComment()
    
    func addComment(toPost post: Post, text: String, completion: @escaping(_ success: Bool) -> Void) {
        
        CKContainer.default().fetchUserRecordID { (appleUserReferenceID, error) in
            
            if let error = error {
                print("Error addingComment to post > PostController.swift line 108: \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let appleUserReferenceID = appleUserReferenceID else {
                completion(false)
                return
            }
            
            let appleUserReference = CKReference(recordID: appleUserReferenceID, action: CKReferenceAction.deleteSelf)
            
            let comment = Comment(text: text, post: post, appleUserReference: appleUserReference)
            
            let commentRecord = CKRecord(comment: comment)
            
            self.ckPublicDatabase.save(commentRecord) { (commentRecord, error) in
                
                if let error = error {
                    print("Error saving when adding a Comment > PostController.swift line 127 \(error) \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                guard let commentRecord = commentRecord else {
                    completion(false)
                    return
                }
                
                guard let comment = Comment(ckRecord: commentRecord) else { return }
                
                post.comments.append(comment)
                
                completion(true)
            }
        }
    }
    
    // Fetch Posts
    
    func fetchPosts(completion: @escaping(_ success: Bool) -> Void) {
        
        CKContainer.default().fetchUserRecordID { (appleUserReferenceID, error) in
            
            // check for error
            if let error = error {
                print("Error fetching posts: \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            
            // unwrap appleUserReferenceID and turn into CKReference
            guard let appleUserReferenceID = appleUserReferenceID else { return }
            
            let appleUserReference = CKReference(recordID: appleUserReferenceID, action: CKReferenceAction.deleteSelf)
            
            let predicate = NSPredicate(value: true)
            
            let query = CKQuery(recordType: "Post", predicate: predicate)
            
            // what we want back: appleUserReference for posts
            self.ckPublicDatabase.perform(query, inZoneWith: nil) { (records, error) in
                
                if let error = error {
                    print("Error fetching posts query > PostController.swift line 172 \(error) \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                guard let records = records else { // unwrap array of records
                    completion(false)
                    return
                }
                
                // placeholder array for fetched posts
                var fetchedPosts: [Post] = []
                
                // create new posts from that array of records and appnd to a placeholder posts array
                for record in records {
                    guard let newPost = Post(ckRecord: record) else {
                        print("failed to initialize new Post while fetching posts in PostController.swift line 186")
                        completion(false)
                        return
                    }
                    fetchedPosts.append(newPost)
                }
                
                // add to source of truth
                self.posts = fetchedPosts
                completion(true)
            }
        }
    }
    
    

    
}


extension PostController {
    
    static let PostsChangedNotification = Notification.Name("PostsChangedNotification")
    static let PostCommentsChangedNotification = Notification.Name("PostCommentsChangedNotification")
}


extension UIImage {
    var jpeg: Data? {
        return UIImageJPEGRepresentation(self, 1)   // QUALITY min = 0 / max = 1
    }
    var png: Data? {
        return UIImagePNGRepresentation(self)
    }
}













