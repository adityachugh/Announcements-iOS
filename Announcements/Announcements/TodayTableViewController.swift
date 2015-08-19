//
//  TodayTableViewController.swift
//  Announcements
//
//  Created by Aditya Chugh on 8/7/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class TodayTableViewController: UITableViewController, PopoverDatePickerDelegate {
    
    var postTableViewManager: PostTableViewManager!
    var date = NSDate()
    var blurView: UIVisualEffectView!
    var window: UIWindow!
    var datePicker = PopoverDatePicker(frame: CGRectMake(0, 0, 300, 200))
    
    override func viewDidLoad() {
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurView = UIVisualEffectView(effect: blurEffect)
        
        self.blurView.frame = self.view.frame
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        postTableViewManager = PostTableViewManager(tableView: tableView, parentViewController: self)
//        tableView.delegate = postTableViewManager
//        tableView.dataSource = postTableViewManager
//        postTableViewManager.parentViewController = self
//        
        
        window = UIApplication.sharedApplication().keyWindow
        
        
        datePicker.delegate = self
        datePicker.center = self.view.center
        datePicker.frame = CGRectOffset(datePicker.frame, 0, -self.view.frame.size.height)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func didCancelDateSelection() {
        window?.addSubview(blurView)
        window?.addSubview(datePicker)
        animateWithCompletion({ (
            ) -> () in
            self.blurView.alpha = 0
            self.datePicker.frame = CGRectOffset(self.datePicker.frame, 0, -self.view.frame.size.height)
            }, completion: {
                () -> () in
                self.blurView.removeFromSuperview()
                self.datePicker.removeFromSuperview()
        })
    }
    
    func didSelectDate(date: NSDate) {
        
        window?.addSubview(blurView)
        window?.addSubview(datePicker)
        self.date = date
        animateWithCompletion({ (
            ) -> () in
            self.blurView.alpha = 0
            self.datePicker.frame = CGRectOffset(self.datePicker.frame, 0, -self.view.frame.size.height)
        }, completion: {
            () -> () in
            self.blurView.removeFromSuperview()
            self.datePicker.removeFromSuperview()
        })
    }
    
    @IBAction func dateButtonTapped(sender: UIBarButtonItem) {
        blurView.alpha = 0
        window?.addSubview(blurView)
        window?.addSubview(datePicker)
        animate { () -> () in
            self.blurView.alpha = 1
            self.datePicker.center = self.view.center
            
            
        }
        
    }
    
    func animate(animations:(() -> ())) {
        UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: nil, animations: {
            () -> Void in
            animations()
            }, completion: nil)
    }
    
    func animateWithCompletion(animations:(() -> ()), completion:(() -> ())) {
        UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: nil, animations: {
            () -> Void in
                animations()
            }, completion: {
            (completed) -> Void in
                completion()
        })
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}