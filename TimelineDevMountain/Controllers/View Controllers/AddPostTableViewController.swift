//
//  AddPostTableViewController.swift
//  TimelineDevMountain
//
//  Created by Michael Guatambu Davis on 7/29/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController, UIImagePickerControllerDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var photoCaptionTextField: UITextField!
    @IBOutlet weak var selectPhotoButtonOutlet: UIButton!
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - Actions
    
    @IBAction func cancelBarButtonTapped(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func selectPhotoButtonTapped(_ sender: UIButton) {
        
        
        
        
        // postImageView.image = #imageLiteral(resourceName: "placeholder_image")
        selectPhotoButtonOutlet.titleLabel?.text = ""
        
    }
    
    @IBAction func addPostButtonTapped(_ sender: UIButton) {
        
        guard   let image = postImageView.image,
                let photoCaption = photoCaptionTextField.text,
                photoCaptionTextField.text != ""
            else {
                
                let alert = UIAlertController(title: "Whoops...", message: "Looks like either a photo or caption is missing.  Please try again.", preferredStyle: .alert)
               
                let okButton = UIAlertAction(title: "OK", style: .default) { (action) -> Void in }

                alert.addAction(okButton)
                
                present(alert, animated: true, completion: nil)
                
                return }
        
        let newPost = Post(photoData: image.jpeg)  // PostController.shared.createPostWith()
        let newComment = Comment(text: photoCaption, post: newPost) // PostController.shared.addComment()

        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - UIImagePicker Delegate Methods
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



































