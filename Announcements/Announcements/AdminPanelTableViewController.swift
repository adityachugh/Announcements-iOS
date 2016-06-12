//
//  AdminPanelTableViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 9/28/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class AdminPanelTableViewController: UITableViewController {
    
    var organization: Organization!
    var levelName: String { get { return organization.levelConfig.levelName } }
    
    private var modifyOrganization: AdminAction!
    
    private var newPost: AdminAction!
    private var allPosts: AdminAction!
    
    private var childOrganizations: AdminAction!
    private var addChildOrganization: AdminAction!
    private var pendingPosts: AdminAction!
    
    private var organizationAdmins: AdminAction!
    private var organizationFollowers: AdminAction!
    
    private var adminPanel: [[AdminAction]]!
    
    override func viewDidLoad() {
        title = organization.name
        
        setupAdminActions()
    }
    
    func setupAdminActions() {
        
        modifyOrganization = AdminAction(title: "Modify \(levelName)", storyboardIdentifier: "ModifyOrganization")
        newPost = AdminAction(title: "New \(levelName) Post", storyboardIdentifier: "NewPost")
        allPosts = AdminAction(title: "All \(levelName) Posts", storyboardIdentifier: "")
        //        allPosts = AdminAction(title: "All \(levelName) Posts", storyboardIdentifier: "AllPosts")
        organizationAdmins = AdminAction(title: "View \(levelName) Admins", storyboardIdentifier: "")
        //        organizationAdmins = AdminAction(title: "View \(levelName) Admins", storyboardIdentifier: "ViewAdmins")
        organizationFollowers = AdminAction(title: "View \(levelName) Followers", storyboardIdentifier: "ViewFollowers")
        
        adminPanel = [[modifyOrganization], [newPost, allPosts], [organizationAdmins, organizationFollowers]]
        
        if let childLevelName = organization.childLevelConfig?.levelName {
            var plural = "\(childLevelName)s"
            if childLevelName[childLevelName.characters.count-1] == "S" || childLevelName[childLevelName.characters.count-1] == "s" {
                plural = "\(childLevelName)es"
            }
            
            childOrganizations = AdminAction(title: "View \(plural)", storyboardIdentifier: "")
            addChildOrganization = AdminAction(title: "Add New \(childLevelName)", storyboardIdentifier: "")
            pendingPosts = AdminAction(title: "View Pending \(childLevelName) Posts", storyboardIdentifier: "")
            //            childOrganizations = AdminAction(title: "View \(plural)", storyboardIdentifier: "ViewChildOrganizations")
            //            addChildOrganization = AdminAction(title: "Add New \(childLevelName)", storyboardIdentifier: "AddNewChild")
            //            pendingPosts = AdminAction(title: "View Pending \(childLevelName) Posts", storyboardIdentifier: "ViewPendingPosts")
            
            adminPanel = [[modifyOrganization], [newPost, allPosts], [childOrganizations, addChildOrganization, pendingPosts], [organizationAdmins, organizationFollowers]]
        } else {
            adminPanel = [[modifyOrganization], [newPost, allPosts], [organizationAdmins, organizationFollowers]]
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let adminAction = adminPanel[indexPath.section][indexPath.row]
        if adminAction.storyboardIdentifier == "" {
            if #available(iOS 8.0, *) {
                let alert = UIAlertController(title: "In Development", message: "This screen is still in development.", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .Cancel, handler: nil))
                presentViewController(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertView(title: "In Development", message: "This screen is still in development.", delegate: nil, cancelButtonTitle: "Okay")
                alert.show()
            }
            
        } else {
            Utilities.presentViewControllerVithStoryboardIdentifier(adminAction.storyboardIdentifier, parentViewController: self) {
                (toViewController) -> UIViewController in
                let toVC = toViewController as! OrganizationTableViewController
                toVC.organization = self.organization
                return toVC
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return adminPanel.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adminPanel[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let adminAction = adminPanel[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = adminAction.title
        
        return cell
    }
    
    private struct AdminAction {
        
        var title:String!
        var storyboardIdentifier:String!
        
        init(title: String, storyboardIdentifier: String) {
            self.title = title
            self.storyboardIdentifier = storyboardIdentifier
        }
    }
}