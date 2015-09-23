//
//  CommentsTableViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/19/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController, RefreshDelegate, TextViewControllerDelegate {
    
    var commentsTableViewManager: CommentsTableViewManager!
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Comments"
    }
    
    override func viewWillAppear(animated: Bool) {
        if commentsTableViewManager == nil {
            commentsTableViewManager = CommentsTableViewManager(tableView: tableView, parentViewController: self, refreshDelegate: self)
            commentsTableViewManager.post = self.post
        }
    }
    
    func refreshData(refreshControl: UIRefreshControl, tableView: UITableView) {
        let parameters: Dictionary = ["startIndex": 0, "numberOfComments": 10, "postObjectId": post.objectId!] as [NSObject : AnyObject]
        PFCloud.callFunctionInBackground("getRangeOfCommentsForPost", withParameters: parameters) {
            (results, error) -> Void in
            if results != nil {
                self.commentsTableViewManager.comments = results as! [Comment]
            }
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }
    
    func addData(refreshControl: UIRefreshControl, tableView: UITableView, startIndex: Int, numberOfPosts: Int) {
        let parameters: Dictionary = ["startIndex": startIndex, "numberOfComments": numberOfPosts, "postObjectId": post.objectId!] as [NSObject : AnyObject]
        PFCloud.callFunctionInBackground("getRangeOfCommentsForPost", withParameters: parameters) {
            (results, error) -> Void in
            if results != nil {
                for result in results as! [Comment] {
                    self.commentsTableViewManager.comments.append(result)
                }
            }
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }
    
    func didCancelTextEntry(viewController: TextViewController) {
        Utilities.animateWithCompletion({
            () -> () in
            viewController.hide()
            }, completion: {
                () -> () in
                viewController.dismissViewControllerAnimated(false, completion: nil)
        })
    }
    
    func didEnterText(viewController: TextViewController, text: String) {
        viewController.shouldShowActivityIndicator = true
        let id = post.objectId!
        let parameters = ["commentText": text, "postObjectId": id] as [NSObject: AnyObject]
        PFCloud.callFunctionInBackground("postCommentAsUserOnPost", withParameters: parameters) {
            (results, error) -> Void in
            
            viewController.shouldShowActivityIndicator = false
            Utilities.animateWithCompletion({
                () -> () in
                viewController.hide()
                }, completion: {
                    () -> () in
                    viewController.dismissViewControllerAnimated(false, completion: nil)
                    self.commentsTableViewManager.comments.insert(results as! Comment, atIndex: 0)
                    self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 1)], withRowAnimation: UITableViewRowAnimation.Top)
            })
        }
    }
}