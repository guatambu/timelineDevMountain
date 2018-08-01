//
//  SearchTableViewController.swift
//  TimelineDevMountain
//
//  Created by Michael Guatambu Davis on 8/1/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    var posts: [Post]?
    
    var searchResults: [SearchableRecord] = []

    
    // MARK: - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
    }
    
    
    // MARK: - SearchBarDelegate methods
    
    func setUpSearchBar() {
        searchBarOutlet.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard   let posts = posts,
                let searchTerm = searchBar.text
            else { return }
        
        guard !searchText.isEmpty else {
            searchResults = posts
            tableView.reloadData()
            return
        }
        
        for post in posts {
            if post.matches(searchTerm: searchTerm) {
                searchResults.append(post)
            }
        }
        tableView.reloadData()
    }
    
    
    // MARK: - Search Button Tapped  ...  with the textDidChange() methd above, do i still need this function?
    
    func searchButtonTapped(searchTerm: String) -> [SearchableRecord] {
        
        searchResults = []
        self.tableView.reloadData()
        
        guard let posts = posts else { return searchResults }
        
        for post in posts {
            if post.matches(searchTerm: searchTerm) {
                searchResults.append(post)
            }
        }
        tableView.reloadData()
        return searchResults
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
        
        if segue.identifier == "toSearchResultDetail" {
            
            // Get the new view controller using segue.destinationViewController.
            
            guard   let indexPath = tableView.indexPathForSelectedRow,
                    let destinationTableViewController = segue.destination as? PostDetailTableViewController
                else { return }
            
            guard let post = searchResults[indexPath.row] as? Post else { return }
            
            // Pass the selected object to the new view controller.
            destinationTableViewController.post = post
        }
    }
}
