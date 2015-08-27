//
//  PopoverDatePicker.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/15/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class PopoverDatePicker: UIView {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var view: UIView!
    var delegate: PopoverDatePickerDelegate!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("PopoverDatePicker", owner: self, options: nil)
        self.addSubview(view)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("PopoverDatePicker", owner: self, options: nil)
        self.bounds = self.view.bounds
        self.addSubview(view)
    }

    @IBAction func doneButtonTapped(sender: UIButton) {
        delegate.didSelectDate(datePicker.date)
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        delegate.didCancelDateSelection()
    }
}

protocol PopoverDatePickerDelegate {
    func didCancelDateSelection() -> ()
    func didSelectDate(date: NSDate) -> ()
}
