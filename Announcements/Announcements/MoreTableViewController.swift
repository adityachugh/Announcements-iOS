//
//  MoreTableViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 10/4/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class MoreTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {
                (_) -> Void in
                PFUser.logOutInBackground()
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.displayOnboarding(true)
            }))
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: {
                (_) -> Void in
                
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
        }
        
    }
}
