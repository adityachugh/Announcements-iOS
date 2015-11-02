//
//  DatePickerTableViewCell.swift
//  infor[me]
//
//  Created by Aditya Chugh on 11/1/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell, DatePickerViewControllerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var minimumDate: NSDate?
    var parentViewController: UIViewController?
    var date: NSDate? {
        didSet {
            dateLabel.text = dateFormatter.stringFromDate(date!)
        }
    }
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var dateFormatter = NSDateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateFormatter.dateFormat = "MMM dd, hh:mm a"
        dateLabel.text = "Date"
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if let parentVC = parentViewController {
                Utilities.presentViewControllerModallyVithStoryboardIdentifier("DatePicker", parentViewController: parentVC, modifications: {
                    (toViewController) -> UIViewController in
                    if let toVC = toViewController as? DatePickerViewController {
                        toVC.delegate = self
                        toVC.date = self.date
                        toVC.datePickerMode = UIDatePickerMode.DateAndTime
                        toVC.minuteInterveral = 15
                        toVC.minimumDate = self.minimumDate
                        return toVC
                    }
                    return toViewController
                })
            }
        }
    }
    
    func didCancelDateSelection() {
        
    }
    
    func didSelectDate(date: NSDate) {
        self.date = date
    }
}
