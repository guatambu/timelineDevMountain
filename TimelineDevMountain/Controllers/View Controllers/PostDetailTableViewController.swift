//
//  PostDetailTableViewController.swift
//  TimelineDevMountain
//
//  Created by Michael Guatambu Davis on 7/28/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    var post: Post?
    
    
    // MARK: - ViewController Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        updateViews()
    }
    
    
    // MARK: - updateViews()
    
    func updateViews() {
        
        guard let post = post else { return }
        
        headerImageView.image = post.photo
        
        tableView.reloadData()
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func commentButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Leave a comment", message: "Got something to say?", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Tap to start typing a comment"
            textField.clearButtonMode = .whileEditing
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in }
        let okButton = UIAlertAction(title: "OK", style: .default) { (action) -> Void in

            guard   let commentText = alert.textFields![0].text,
                    let post = self.post,
                    alert.textFields![0].text != ""
                else { return }
            
            let newComment = Comment(text: commentText, post: post)  // compiler not giving addComent via PostController as an option
            
            post.comments.append(newComment)
            
            self.tableView.reloadData()
        }
        
        alert.addAction(cancel)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func followPostButtonTapped(_ sender: UIButton) {
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        guard let post = post else { return 0 }
        
        return post.comments.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCommentCell", for: indexPath)

        // Configure the cell...
        if let post = post {
            
            let comment = post.comments[indexPath.row]
            let date = post.timestamp
            
            cell.textLabel?.text = comment.text
            cell.detailTextLabel?.text = "\(date)"
            
        }
        return cell
    }
}
