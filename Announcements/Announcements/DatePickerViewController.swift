//
//  DatePickerViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/27/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    var date: NSDate?
    var minimumDate: NSDate?
    var maximumDate: NSDate?
    var delegate: DatePickerViewControllerDelegate?
    var backgroundImage: UIImage?
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.clearColor()
        
        backgroundImageView.image = backgroundImage
        if let dateToSet = date {
            datePicker.date = dateToSet
        }
        datePicker.minimumDate = self.minimumDate
        datePicker.maximumDate = self.maximumDate
    }
    
    override func viewWillAppear(animated: Bool) {
        hide()
    }
    
    override func viewDidAppear(animated: Bool) {
        Utilities.animate {
            () -> () in
            self.show()
        }
    }
    
    func hide() {
        backgroundView.alpha = 0
        datePickerView.frame = CGRectOffset(datePicker.frame, 0, -view.bounds.size.height)
    }
    
    func show() {
        self.backgroundView.alpha = 1
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
    func didCancelDateSelection()
    func didSelectDate(date: NSDate)
}