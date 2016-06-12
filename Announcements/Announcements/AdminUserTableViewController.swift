//
//  AdminUserTableViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 2/3/16.
//  Copyright © 2016 Mindbend Studio. All rights reserved.
//

import UIKit

class AdminUserTableViewController: UserTableViewController {
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            deleteUser(indexPath)
        }
    }
    
    func deleteUser(indexPath: NSIndexPath) {
        followers.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
}
