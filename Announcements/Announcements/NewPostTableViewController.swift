//
//  NewPostTableViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 10/14/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class NewPostTableViewController: UITableViewController {
    
    var organization: Organization!
    
    var titleTableViewCell: TextInputTableViewCell?
    var bodyTableViewCell: TextViewTableViewCell?
    
    var startDateTableViewCell: DatePickerTableViewCell?
    var endDateTableViewCell: DatePickerTableViewCell?
    
    var notifyParentTableViewCell: SwitchTableViewCell?
    var priorityTableViewCell: SegmentedControlTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "TextInputTableViewCell", bundle: nil), forCellReuseIdentifier: "TextInput")
        tableView.registerNib(UINib(nibName: "TextViewTableViewCell", bundle: nil), forCellReuseIdentifier: "TextView")
        tableView.registerNib(UINib(nibName: "DatePickerTableViewCell", bundle: nil), forCellReuseIdentifier: "DatePicker")
        tableView.registerNib(UINib(nibName: "SwitchTableViewCell", bundle: nil), forCellReuseIdentifier: "Switch")
        tableView.registerNib(UINib(nibName: "SegmentedControlTableViewCell", bundle: nil), forCellReuseIdentifier: "SegmentedControl")
        title = "New Post"
        
        let postButton = UIBarButtonItem(title: "Submit", style: UIBarButtonItemStyle.Done, target: self, action: "submitPost")
        navigationItem.rightBarButtonItem = postButton
        
        tableView.bottomRefreshControl = nil
    }
    
    func submitPost() {
        if titleTableViewCell?.input == nil || titleTableViewCell?.input?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" {
            RKDropdownAlert.title("Submit Failed", message: "Please enter a title.", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
        } else if bodyTableViewCell?.body == nil || bodyTableViewCell?.body.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" {
            RKDropdownAlert.title("Submit Failed", message: "Please enter a body for the post.", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
        } else if startDateTableViewCell?.date == nil {
            RKDropdownAlert.title("Submit Failed", message: "Please select a start date.", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
        } else if endDateTableViewCell?.date == nil {
            RKDropdownAlert.title("Submit Failed", message: "Please select an end date.", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
        }
        else {
            let endDate = endDateTableViewCell!.date!
            let startDate = startDateTableViewCell!.date!
            if endDate.isEarlierThan(startDate) {
                RKDropdownAlert.title("Submit Failed", message: "The start date must be before the end date.", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
            } else {
                let priority = 3-(priorityTableViewCell?.selectedSegment)!
                let parameters: Dictionary = ["organizationObjectId": organization.objectId!, "title": titleTableViewCell!.input!, "body": bodyTableViewCell!.body!, "startDate": startDateTableViewCell!.date!, "endDate": endDateTableViewCell!.date!, "priority": priority, "notifyParent": notifyParentTableViewCell!.isOn]
                PFCloud.callFunctionInBackground("uploadPostForOrganization", withParameters: parameters) {
                    (results, error) -> Void in
                    if error != nil {
                        print(error!)
                    } else {
                        print("Submitted")
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: return 2
        case 1: return 2
        case 2: return 2
        default: return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 1 {
            return 150
        } else {
            return 44
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // Section 1
            switch indexPath.row {
            case 0:
                if let titleCell = titleTableViewCell {
                    return titleCell
                } else {
                    let cell = tableView.dequeueReusableCellWithIdentifier("TextInput", forIndexPath: indexPath) as! TextInputTableViewCell
                    cell.title = "Title"
                    titleTableViewCell = cell
                    return cell
                }
            case 1:
                if let bodyCell = bodyTableViewCell {
                    return bodyCell
                } else {
                    let cell = tableView.dequeueReusableCellWithIdentifier("TextView", forIndexPath: indexPath) as! TextViewTableViewCell
                    cell.title = "Body"
                    bodyTableViewCell = cell
                    return cell
                }
//            case 2:
//                let cell = tableView.dequeueReusableCellWithIdentifier("TextInput", forIndexPath: indexPath) as! TextInputTableViewCell
//                cell.title = "Image"
//                return cell
            default: _ = 0;
            }
        case 1: // Section 2
            switch indexPath.row {
            case 0:
                if let startDate = startDateTableViewCell {
                    return startDate
                } else {
                    let cell = tableView.dequeueReusableCellWithIdentifier("DatePicker", forIndexPath: indexPath) as! DatePickerTableViewCell
                    cell.title = "Start Date"
                    cell.parentViewController = self
                    cell.minimumDate = NSDate()
                    startDateTableViewCell = cell
                    return cell
                }
            case 1:
                if let startDate = endDateTableViewCell {
                    return startDate
                } else {
                    let cell = tableView.dequeueReusableCellWithIdentifier("DatePicker", forIndexPath: indexPath) as! DatePickerTableViewCell
                    cell.title = "End Date"
                    cell.parentViewController = self
                    endDateTableViewCell = cell
                    cell.minimumDate = NSDate()
                    return cell
                }
            default: _ = 0;
            }
        case 2: // Section 3
            switch indexPath.row {
            case 0:
                if let notifyParent = notifyParentTableViewCell {
                    return notifyParent
                } else {
                    let cell = tableView.dequeueReusableCellWithIdentifier("Switch", forIndexPath: indexPath) as! SwitchTableViewCell
                    cell.title = "Notify Parent"
                    cell.isOn = false
                    notifyParentTableViewCell = cell
                    return cell
                }
            case 1:
                if let priority = priorityTableViewCell {
                    return priority
                } else {
                    let cell = tableView.dequeueReusableCellWithIdentifier("SegmentedControl", forIndexPath: indexPath) as! SegmentedControlTableViewCell
                    cell.title = "Priority"
                    cell.segments = ["Low", "Medium", "High"]
                    cell.segmentedControl.selectedSegmentIndex = 0
                    priorityTableViewCell = cell
                    return cell
                }
            default: _ = 0;
            }
        default: return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DatePicker", forIndexPath: indexPath) as! DatePickerTableViewCell
        
        cell.parentViewController = self
        
        return cell
    }
    
}
