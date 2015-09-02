//
//  CommentsTableViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/19/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController, RefreshDelegate {
    
    var commentsTableViewManager: CommentsTableViewManager!
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsTableViewManager = CommentsTableViewManager(tableView: tableView, parentViewController: self, refreshDelegate: self)
        commentsTableViewManager.post = self.post
        title = "Comments"
    }
    
    func refreshData(refreshControl: UIRefreshControl, tableView: UITableView) {
        var parameters: Dictionary = ["startIndex": 0, "numberOfComments": 10, "postObjectId": post.objectId!] as [NSObject : AnyObject]
        PFCloud.callFunctionInBackground("getRangeOfCommentsForPost", withParameters: parameters) {
            (results, error) -> Void in
            if results != nil {
                self.commentsTableViewManager.comments = results as! [Comment]
            }
            tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func addData(refreshControl: UIRefreshControl, tableView: UITableView, startIndex: Int, numberOfPosts: Int) {
        var parameters: Dictionary = ["startIndex": startIndex, "numberOfComments": numberOfPosts, "postObjectId": post.objectId!] as [NSObject : AnyObject]
        PFCloud.callFunctionInBackground("getRangeOfCommentsForPost", withParameters: parameters) {
            (results, error) -> Void in
            if results != nil {
                for result in results as! [Comment] {
                    self.commentsTableViewManager.comments.append(result)
                }
            }
            tableView.reloadData()
            refreshControl.endRefreshing()
        }
        
    }
}
