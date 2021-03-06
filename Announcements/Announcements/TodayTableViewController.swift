//
//  TodayTableViewController.swift
//  Announcements
//
//  Created by Aditya Chugh on 8/7/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit
//import Parse

class TodayTableViewController: ErrorMessageTableViewController, RefreshDelegate, DatePickerViewControllerDelegate {
    
    var postTableViewManager: PostTableViewManager!
    var date = NSDate()
    var window: UIWindow!
    var datePicker = PopoverDatePicker(frame: CGRectMake(0, 0, 300, 200))
    var datePickerIsShowing = false
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if postTableViewManager == nil && User.currentUser() != nil {
            postTableViewManager = PostTableViewManager(tableView: tableView, parentViewController: self, refreshDelegate: self)
        }
    }
    
    func refreshData(refreshControl: UIRefreshControl, tableView: UITableView) {
        let parameters: Dictionary = ["startIndex": 0, "numberOfPosts": 10, "date": date]
        PFCloud.callFunctionInBackground("getRangeOfPostsForDay", withParameters: parameters) {
            (results, error) -> Void in
            if results != nil {
                if (results as! [Post]).count > 0 {
                    self.postTableViewManager.data = results as! [Post]
                    self.hideEmptyDataSetMessage()
                    tableView.reloadData()
                    refreshControl.endRefreshing()
                } else {
                    self.showEmptyDataSetMessage("No Posts for Day")
                    //                    RKDropdownAlert.title("No Posts", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
                    refreshControl.endRefreshing()
                }
            } else {
                self.showEmptyDataSetMessage("No Posts for Day")
                //                RKDropdownAlert.title("No Posts", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
                refreshControl.endRefreshing()
            }
        }
    }
    
    func addData(refreshControl: UIRefreshControl, tableView: UITableView, startIndex: Int, numberOfPosts: Int) {
        let parameters: Dictionary = ["startIndex": startIndex, "numberOfPosts": numberOfPosts, "date": date]
        PFCloud.callFunctionInBackground("getRangeOfPostsForDay", withParameters: parameters) {
            (results, error) -> Void in
            if results != nil {
                for result in results as! [Post] {
                    self.postTableViewManager.data.append(result)
                }
            }
            tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func didCancelDateSelection() {
        
    }
    
    func didSelectDate(date: NSDate) {
        self.date = date
        self.postTableViewManager.refreshTop()
    }
    
    @IBAction func dateButtonTapped(sender: UIBarButtonItem) {
        Utilities.presentViewControllerModallyVithStoryboardIdentifier("DatePicker", parentViewController: self) { (toViewController) -> UIViewController in
            let datePickerViewController = toViewController as! DatePickerViewController
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