//
//  DatePickerViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/27/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    var date: NSDate?
    var minimumDate: NSDate?
    var maximumDate: NSDate?
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    var delegate: DatePickerViewControllerDelegate?
    var orientations:UIInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
    var backgroundImage: UIImage?
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.clearColor()
        
        backgroundImageView.image = backgroundImage
        if let dateToSet = date {
            datePicker.date = dateToSet
        }
        datePicker.minimumDate = self.minimumDate
        datePicker.maximumDate = self.maximumDate
        
        hide()
    }
    
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged:", name: UIDeviceOrientationDidChangeNotification, object: nil)
        Utilities.animate {
            () -> () in
            self.show()
        }
    }
    
    func orientationChanged (notification: NSNotification) {
        show()
    }
    
    func hide() {
        blurView.alpha = 0
        datePickerView.frame = CGRectOffset(datePicker.frame, 0, -view.bounds.size.height)
    }
    
    func show() {
        self.blurView.alpha = 1
        self.datePickerView.center = self.view.center
        
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        delegate?.didCancelDateSelection()
        Utilities.animateWithCompletion({
            () -> () in
            self.hide()
        }, completion: {
            () -> () in
            self.dismissViewControllerAnimated(false, completion: nil)
        })
        
    }
    
    @IBAction func doneTapped(sender: AnyObject) {
        delegate?.didSelectDate(datePicker.date)
        Utilities.animateWithCompletion({
            () -> () in
            self.hide()
        }, completion: {
            () -> () in
            self.dismissViewControllerAnimated(false, completion: nil)
        })
    }
}

protocol DatePickerViewControllerDelegate {
    func didCancelDateSelection() -> ()
    func didSelectDate(date: NSDate) -> ()
}