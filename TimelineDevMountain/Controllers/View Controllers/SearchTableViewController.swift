//
//  SearchTableViewController.swift
//  TimelineDevMountain
//
//  Created by Michael Guatambu Davis on 8/1/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    var searchResults: [SearchableRecord] = []
    
    
    
    // MARK: - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard   let post = searchResults[indexPath.row] as? Post,
                let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultsCell", for: indexPath) as? PostTableViewCell
            else { return UITableViewCell() }

        // Configure the cell...
        cell.cellImageView.image = post.photo
        
        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
 
 
    }
}
