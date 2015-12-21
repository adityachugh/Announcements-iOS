//
//  ModifyOrganizationTableViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 11/22/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class ModifyOrganizationTableViewController: AdminTableViewController {
    
    var nameTableViewCell: TextInputTableViewCell!
    var handleTableViewCell: TextInputTableViewCell!
    var descriptionTableViewCell: TextInputTableViewCell!
    
    var profilePhotoTableViewCell: UITableViewCell!
    var coverPhotoTableViewCell: UITableViewCell!
    
    var organizationTypeTableViewCell: SegmentedControlTableViewCell!
    var hasAccessCodeTableViewCell: SwitchTableViewCell!
    var accessCodeTableViewCell: TextInputTableViewCell!
    
    var menuItems: [[UITableViewCell]]!
    
    var hasAccessCodeIsShowing = false
    var accessCodeIsShowing = false
    
    override func viewDidLoad() {
        
        title = "Modify \(organization.levelConfig.levelName)"
        
        setupNibs()
        setupTableView()
        
        if organizationTypeTableViewCell.selectedSegment == 1 {
            if hasAccessCodeTableViewCell.isOn == true {
                setupMenuWithAccessCode()
            } else {
                setupMenuWithHasAccessCode()
            }
        } else {
            setupMenu()
        }
        
        let submitButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Done, target: self, action: "submitTapped")
        self.navigationItem.rightBarButtonItem = submitButton
    }
    
    func submitTapped() {
        if let name = nameTableViewCell.input {
            if name == "" {
                RKDropdownAlert.title("Save Failed", message: "Name cannot be blank!", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
                return
            }
        } else {
            RKDropdownAlert.title("Save Failed", message: "Name cannot be blank!", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
            return
        }
        if hasAccessCodeTableViewCell.isOn == true {
            if let accessCode = accessCodeTableViewCell.input {
                if accessCode == "" {
                    RKDropdownAlert.title("Save Failed", message: "Access code cannot be blank!", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
                    return
                } else if accessCode.characters.count < 4 || accessCode.characters.count > 4 {
                    RKDropdownAlert.title("Save Failed", message: "Access code must be 4 numbers!", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
                    return
                }
            }
        }
        let accessCode = hasAccessCodeTableViewCell.isOn == true ? Int(accessCodeTableViewCell.input!) : nil
        let organizationType = organizationTypeTableViewCell.selectedSegment == 0 ? "PUB" : "PRI"
        CloudCodeFunctions.updateOrganizationFields(organization.objectId!, description: descriptionTableViewCell.input!, name: nameTableViewCell.input!,hasAccessCode: hasAccessCodeTableViewCell.isOn, accessCode: accessCode, organizationType: organizationType) {
                (org, error) -> () in
            if error == nil {
                print(org)
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func setupMenu() {
        menuItems = [[nameTableViewCell, handleTableViewCell, descriptionTableViewCell], [profilePhotoTableViewCell, coverPhotoTableViewCell], [organizationTypeTableViewCell]]
    }
    
    func setupMenuWithHasAccessCode() {
        menuItems = [[nameTableViewCell, handleTableViewCell, descriptionTableViewCell], [profilePhotoTableViewCell, coverPhotoTableViewCell], [organizationTypeTableViewCell, hasAccessCodeTableViewCell]]
    }
    
    func setupMenuWithAccessCode() {
        menuItems = [[nameTableViewCell, handleTableViewCell, descriptionTableViewCell], [profilePhotoTableViewCell, coverPhotoTableViewCell], [organizationTypeTableViewCell, hasAccessCodeTableViewCell, accessCodeTableViewCell]]
    }
    
    func setupNibs() {
        tableView.registerNib(UINib(nibName: "TextInputTableViewCell", bundle: nil), forCellReuseIdentifier: "TextInput")
        tableView.registerNib(UINib(nibName: "TextViewTableViewCell", bundle: nil), forCellReuseIdentifier: "TextView")
        tableView.registerNib(UINib(nibName: "DatePickerTableViewCell", bundle: nil), forCellReuseIdentifier: "DatePicker")
        tableView.registerNib(UINib(nibName: "SwitchTableViewCell", bundle: nil), forCellReuseIdentifier: "Switch")
        tableView.registerNib(UINib(nibName: "SegmentedControlTableViewCell", bundle: nil), forCellReuseIdentifier: "SegmentedControl")
        
    }
    
    func setupTableView() {
        nameTableViewCell = tableView.dequeueReusableCellWithIdentifier("TextInput") as! TextInputTableViewCell
        nameTableViewCell.title = "Name"
        nameTableViewCell.input = organization.name
        
        handleTableViewCell = tableView.dequeueReusableCellWithIdentifier("TextInput") as! TextInputTableViewCell
        handleTableViewCell.title = "Handle"
        handleTableViewCell.input = "#\(organization.handle)"
        handleTableViewCell.inputTextField.enabled = false
        handleTableViewCell.inputTextField.textColor = UIColor.grayColor()
        
        descriptionTableViewCell = tableView.dequeueReusableCellWithIdentifier("TextInput") as! TextInputTableViewCell
        descriptionTableViewCell.title = "Description"
        descriptionTableViewCell.input = organization.organizationDescription
        
        profilePhotoTableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "ProfilePicture")
        profilePhotoTableViewCell.textLabel?.text = "Profile Photo"
        profilePhotoTableViewCell.textLabel?.font = UIFont(name: "AvenirNext-Medium", size: 17.0)
        profilePhotoTableViewCell.accessoryType = .DisclosureIndicator
        
        coverPhotoTableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "CoverPhoto")
        coverPhotoTableViewCell.textLabel?.text = "Cover Photo"
        coverPhotoTableViewCell.textLabel?.font = UIFont(name: "AvenirNext-Medium", size: 17.0)
        coverPhotoTableViewCell.accessoryType = .DisclosureIndicator
        
        organizationTypeTableViewCell = tableView.dequeueReusableCellWithIdentifier("SegmentedControl") as! SegmentedControlTableViewCell
        organizationTypeTableViewCell.title = "\(organization.levelConfig.levelName) Type"
        organizationTypeTableViewCell.segments = ["Public", "Private"]
        organizationTypeTableViewCell.segmentedControl.selectedSegmentIndex = organization.organizationType == "PUB" ? 0 : 1
        organizationTypeTableViewCell.segmentedControl.addTarget(self, action: "organizationTypeChanged", forControlEvents: UIControlEvents.ValueChanged)
        
        hasAccessCodeTableViewCell = tableView.dequeueReusableCellWithIdentifier("Switch") as! SwitchTableViewCell
        hasAccessCodeTableViewCell.title = "Has Access Code"
        hasAccessCodeTableViewCell.isOn = organization.hasAccessCode
        hasAccessCodeTableViewCell.stateSwitch.addTarget(self, action: "hasAccessCodeChanged", forControlEvents: UIControlEvents.ValueChanged)
        
        accessCodeTableViewCell = tableView.dequeueReusableCellWithIdentifier("TextInput") as! TextInputTableViewCell
        accessCodeTableViewCell.title = "Access Code"
        if organization.accessCode > 0 {
            accessCodeTableViewCell.input = "\(organization.accessCode)"
        } else {
            accessCodeTableViewCell.input = ""
        }
        accessCodeTableViewCell.placeholder = "1234"
        accessCodeTableViewCell.inputTextField.keyboardType = UIKeyboardType.NumberPad
        accessCodeTableViewCell.maxCharacterCount = 4
        accessCodeTableViewCell.hideMaxCharacterCount = true
    }
    
    func organizationTypeChanged() {
        if organizationTypeTableViewCell.selectedSegment == 1 {
            setupMenuWithHasAccessCode()
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 1)], withRowAnimation: UITableViewRowAnimation.Top)
            hasAccessCodeIsShowing = true
            accessCodeIsShowing = false
        } else {
            setupMenu()
            var indexPaths = [NSIndexPath(forRow: 1, inSection: 1)]
            if accessCodeIsShowing {
                indexPaths.append(NSIndexPath(forRow: 2, inSection: 1))
                hasAccessCodeTableViewCell.isOn = false
            }
            self.tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Top)
            hasAccessCodeIsShowing = false
            accessCodeIsShowing = false
        }
    }
    
    func hasAccessCodeChanged() {
        if hasAccessCodeTableViewCell.isOn == true {
            setupMenuWithAccessCode()
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 1)], withRowAnimation: UITableViewRowAnimation.Top)
            hasAccessCodeIsShowing = true
            accessCodeIsShowing = true
        } else {
            setupMenuWithHasAccessCode()
            self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 1)], withRowAnimation: UITableViewRowAnimation.Top)
            hasAccessCodeIsShowing = true
            accessCodeIsShowing = false
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return menuItems.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return menuItems[indexPath.section][indexPath.row]
    }
    
}