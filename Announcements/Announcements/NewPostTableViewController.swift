//
//  NewPostTableViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 10/14/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class NewPostTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "TextInputTableViewCell", bundle: nil), forCellReuseIdentifier: "TextInput")
        
        title = "New Post"
        
        let postButton = UIBarButtonItem(title: "Submit", style: UIBarButtonItemStyle.Done, target: self, action: "submitPost")
        navigationItem.rightBarButtonItem = postButton
    }

    func submitPost() {
        print("Submit!")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextInput", forIndexPath: indexPath) as! TextInputTableViewCell
        
        cell.title = "Title \(indexPath.row)"
        cell.placeholder = "Placeholder \(indexPath.row)"
        cell.maxCharacterCount = 10*(indexPath.row+1)
        // Configure the cell...

        return cell
    }

}
