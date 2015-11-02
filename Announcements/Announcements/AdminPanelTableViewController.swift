//
//  AdminPanelTableViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 9/28/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class AdminPanelTableViewController: UITableViewController {
    
    var organization: Organization!
    
    override func viewDidLoad() {
        title = organization.name
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        Utilities.presentViewControllerVithStoryboardIdentifier("New Post", parentViewController: self) {
            (toViewController) -> UIViewController in
            let toVC = toViewController as! NewPostTableViewController
            toVC.organization = self.organization
            return toVC
        }
    }
}
