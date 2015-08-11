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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 180
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Post", forIndexPath: indexPath) as! PostTableViewCell
        cell.backgroundColor = UIColor.clearColor()
        
        println(cell.view.frame.width)
        cell.view.frame = CGRectMake(cell.view.frame.origin.x, cell.view.frame.origin.y, self.view.frame.size.width, cell.view.frame.size.height)
        
        return cell
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
