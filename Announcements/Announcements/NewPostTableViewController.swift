//
//  NewPostTableViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 10/14/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class NewPostTableViewController: UITableViewController {
    
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
            
        } else if bodyTableViewCell?.body == nil || bodyTableViewCell?.body.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" {
            
        } else if startDateTableViewCell?.date == nil || startDateTableViewCell?.date < NSDate() {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: return 3
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
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("TextInput", forIndexPath: indexPath) as! TextInputTableViewCell
                cell.title = "Image"
                return cell
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
