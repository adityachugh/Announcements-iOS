//
//  FollowerTableViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 2/2/16.
//  Copyright © 2016 Mindbend Studio. All rights reserved.
//

import UIKit

class FollowerTableViewController: AdminUserTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Followers"
    }
    
    override func loadUsers() {
        startIndex = 0
        hideEmptyDataSetMessage()
        CloudCodeFunctions.getFollowersForOrganizationInRange(organization.objectId!, startIndex: startIndex, numberOfUsers: numberOfUsers) { (followers, error) -> () in
            if error != nil {
                super.showEmptyDataSetMessage("Failed to load followers")
                return
            }
            if followers?.count > 0 {
                self.followers = followers!
                self.topRefreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    override func addUsers() {
        CloudCodeFunctions.getFollowersForOrganizationInRange(organization.objectId!, startIndex: startIndex, numberOfUsers: numberOfUsers) { (followers, error) -> () in
            if error != nil {
                return
            }
            if followers?.count > 0 {
                self.followers.appendContentsOf(followers!)
                self.bottomRefreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    override func deleteUser(indexPath: NSIndexPath) {
        super.deleteUser(indexPath)
        followers.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        CloudCodeFunctions.removeFollowerFromOrganization(organization.objectId!, selectedFollowerToRemoveObjectId: followers[indexPath.row].objectId!) {
            (completed, error) -> () in
            
        }
    }
}
