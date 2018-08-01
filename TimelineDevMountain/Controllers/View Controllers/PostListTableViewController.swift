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

        setUpSearchController()
        
    }
    
    
    // MARK: - searchController Functions
    
    func setUpSearchController() {
        let resultsController = SearchResultsTableViewController()
        let searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search Posts"
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchBarIsEmpty(searchController: searchController)
    }
    
    func searchBarIsEmpty(searchController: UISearchController) -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchTerm(_ searchTerm: String, scope: String = "All") {
        let searchResultsController = SearchResultsTableViewController()
        searchResultsController.resultsArray = PostController.shared.posts.filter{ (post: Post) -> Bool in
            return post.matches(searchTerm: searchTerm)
        }
        tableView.reloadData()
    }


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

extension PostListTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchTerm(searchController.searchBar.text!)
    }
    
    
}

































