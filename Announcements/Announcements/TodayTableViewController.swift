//
//  TodayTableViewController.swift
//  Announcements
//
//  Created by Aditya Chugh on 8/7/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit
//import Parse

class TodayTableViewController: UITableViewController, PostTableViewRefreshDelegate, DatePickerViewControllerDelegate {
    
    var postTableViewManager: PostTableViewManager!
    var date = NSDate()
    var blurView: UIVisualEffectView!
    var window: UIWindow!
    var datePicker = PopoverDatePicker(frame: CGRectMake(0, 0, 300, 200))
    var datePickerIsShowing = false
    
    override func viewDidLoad() {
        postTableViewManager = PostTableViewManager(tableView: tableView, parentViewController: self, refreshDelegate: self)
    }
    
    func refreshData(refreshControl: UIRefreshControl, tableView: UITableView) {
        var parameters: Dictionary = ["startIndex": 0, "numberOfPosts": 10, "date": date]
        PFCloud.callFunctionInBackground("getRangeOfPostsForDay", withParameters: parameters) {
            (results, error) -> Void in
            self.postTableViewManager.data = results as! [Post]
            tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func addData() {
        
    }
    
    func didCancelDateSelection() {
        
    }
    
    func didSelectDate(date: NSDate) {
        self.date = date
        self.postTableViewManager.refreshTop()
    }
    
    @IBAction func dateButtonTapped(sender: UIBarButtonItem) {
        Utilities.presentViewControllerModallyVithStoryboardIdentifier("DatePicker", parentViewController: self) { (toViewController) -> UIViewController in
            var datePickerViewController = toViewController as! DatePickerViewController
            datePickerViewController.delegate = self
            datePickerViewController.date = self.date
            datePickerViewController.maximumDate = NSDate()
            return datePickerViewController
        }
    }
    
    //Misc
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}