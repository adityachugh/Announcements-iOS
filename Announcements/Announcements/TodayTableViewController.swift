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
    var orientations:UIInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
    var datePickerIsShowing = false
    
    override func viewDidLoad() {
        postTableViewManager = PostTableViewManager(tableView: tableView, parentViewController: self)
        setupDatePicker()
    }
    
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged:", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func orientationChanged (notification: NSNotification) {
        if datePickerIsShowing {
            fixDatePickerWhenShowing()
        }
    }
    
    //PopoverDatePicker
    
    func setupDatePicker() {
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurView = UIVisualEffectView(effect: blurEffect)
        window = UIApplication.sharedApplication().keyWindow
        blurView.frame = window.bounds
        datePicker.delegate = self
        datePicker.center = window.center
        datePicker.frame = CGRectOffset(datePicker.frame, 0, -self.view.bounds.size.height)
    }
    
    func fixDatePickerWhenShowing() {
        blurView.frame = window.bounds
        datePicker.center = window.center
    }

    func didCancelDateSelection() {
        window?.addSubview(blurView)
        window?.addSubview(datePicker)
        Utilities.animateWithCompletion({ (
            ) -> () in
            self.blurView.alpha = 0
            self.datePicker.frame = CGRectOffset(self.datePicker.frame, 0, -self.view.frame.size.height)
            }, completion: {
                () -> () in
                self.datePickerIsShowing = false
                self.blurView.removeFromSuperview()
                self.datePicker.removeFromSuperview()
        })
    }
    
    func didSelectDate(date: NSDate) {
        
        window?.addSubview(blurView)
        window?.addSubview(datePicker)
        self.date = date
        Utilities.animateWithCompletion({ () -> () in
            self.blurView.alpha = 0
            self.datePicker.frame = CGRectOffset(self.datePicker.frame, 0, -self.view.frame.size.height)
        }, completion: { () -> () in
           self.datePickerIsShowing = false
            self.blurView.removeFromSuperview()
            self.datePicker.removeFromSuperview()
        })
    }
    
    @IBAction func dateButtonTapped(sender: UIBarButtonItem) {
        setupDatePicker()
        datePickerIsShowing = true
        blurView.alpha = 0
        window?.addSubview(blurView)
        window?.addSubview(datePicker)
        Utilities.animate { () -> () in
            self.blurView.alpha = 1
            self.datePicker.center = self.view.center
            
            
        }
        
    }
    
    //Misc
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}