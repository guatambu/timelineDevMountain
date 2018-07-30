//
//  PostController.swift
//  TimelineDevMountain
//
//  Created by Michael Guatambu Davis on 7/28/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class PostController {
    
    // MARK: - Properties
    
    static let shared = PostController()
    
    var posts: [Post] = []
    
    // MARK: - CRUD Functions (Create, Read, Update, Delete)
    
    // addComment()
    
    func addComment(toPost post: Post, text: String, completion: @escaping(_ success: Bool) -> Void) {
        
        let comment = Comment(text: text, post: post)
        
    }
    
    // Create
    
    func createPostWith(image: UIImage, caption: String, completion: @escaping(_ success: Bool) -> Void) {
        
        let data = image.jpeg
        let post = Post(photoData: data)
        
        let comment = Comment(text: caption, post: post)
        
    }
}


extension UIImage {
    var jpeg: Data? {
        return UIImageJPEGRepresentation(self, 1)   // QUALITY min = 0 / max = 1
    }
    var png: Data? {
        return UIImagePNGRepresentation(self)
    }
}













