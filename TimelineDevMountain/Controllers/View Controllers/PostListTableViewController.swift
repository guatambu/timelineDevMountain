//
//  PostListTableViewController.swift
//  TimelineDevMountain
//
//  Created by Michael Guatambu Davis on 7/28/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    //: MARK - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: - setUpSearchController()
    
    


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PostController.shared.posts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        
        let post = PostController.shared.posts[indexPath.row]
        
        cell.post = post

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toPostDetail" {
            guard   let destinationViewController = segue.destination as? PostDetailTableViewController,
                    let indexPath = tableView.indexPathForSelectedRow
            else { return }
            
            let post = PostController.shared.posts[indexPath.row]
            
            // Pass the selected object to the new view controller.
            destinationViewController.post = post
        }
    }
}
