//
//  PostTableViewCell.swift
//  TimelineDevMountain
//
//  Created by Michael Guatambu Davis on 7/28/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Properties
 
    @IBOutlet weak var cellImageView: UIImageView!
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - updateViews()
    
    func updateViews() {
        guard let post = post else { return }
        
        cellImageView.image = post.photo
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
