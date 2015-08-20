//
//  CommentsTableViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/19/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController {

    var commentsTableViewManager: CommentsTableViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTableViewManager = CommentsTableViewManager(tableView: tableView, parentViewController: self)
        title = "Comments"
    }
}
