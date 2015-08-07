//
//  TodayTableViewController.swift
//  Announcements
//
//  Created by Aditya Chugh on 8/7/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class TodayTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
