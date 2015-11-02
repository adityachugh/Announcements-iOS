//
//  OrganizationViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/14/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class OrganizationViewController: UIViewController, ScrollingDelegate, RefreshDelegate, FollowButtonDelegate {
    
    @IBOutlet weak var organizationFollowCountLabel: UILabel!
    @IBOutlet weak var organizationProfilePictureImageView: PFImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var organizationHandleLabel: UILabel!
    @IBOutlet weak var followButton: FollowButton!
    @IBOutlet weak var topViewContentOffset: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    var postTableViewManager: PostTableViewManager!
    var organization: Organization!
    
    override func viewDidLoad() {
        postTableViewManager = PostTableViewManager(tableView: tableView, parentViewController: self, refreshDelegate: self)
        postTableViewManager.scrollingDelegate = self
        
        organizationProfilePictureImageView.layer.cornerRadius = organizationProfilePictureImageView.frame.size.height/2
        organizationProfilePictureImageView.layer.masksToBounds = true
        
        if let imageFile = organization.image {
            organizationProfilePictureImageView.file = imageFile
        } else {
            organizationProfilePictureImageView.file = nil
            organizationProfilePictureImageView.image = UIImage(named: "Organization_Placeholder")
        }
        title = organization.name
        organizationHandleLabel.text = "@\(organization.handle)"
        organizationFollowCountLabel.text = "\(organization.followerCount) Followers"
        
        checkIfIsFollower()
        followButton.delegate = self
    }
    
    func followButtonTapped(followStatus: String) {
        followButton.showActivityIndicator()
        var parameters: Dictionary = ["" : true, "i": "hello"]
        if followButton.followStatus != "NFO" {
            parameters = ["isFollowing": false, "organizationObjectId": organization.objectId!]
        } else {
            parameters = ["isFollowing": true, "organizationObjectId": organization.objectId!]
        }
        PFCloud.callFunctionInBackground("updateFollowStateForUser", withParameters: parameters as [NSObject : AnyObject]) {
            (result, error) -> Void in
            self.followButton.hideActivityIndicator()
            if error != nil {
                self.followButton.followStatus = "NFO"
                RKDropdownAlert.title("Follow Failed", message: "Failed to follow, Please try again later.", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
            } else {
                if let finalResult = result as? String {
                    self.followButton.followStatus = finalResult
                }
            }
        }
    }
    
    func checkIfIsFollower() {
        followButton.showActivityIndicator()
        let parameters = ["organizationObjectId": organization.objectId!]
        PFCloud.callFunctionInBackground("isFollowingOrganization", withParameters: parameters) {
            (result, error) -> Void in
            self.followButton.hideActivityIndicator()
            if error != nil {
                self.followButton.followStatus = "NFO"
            } else {
                self.followButton.followStatus = result as! String
            }
        }
    }
    
    func refreshData(refreshControl: UIRefreshControl, tableView: UITableView) {
        let parameters: NSDictionary = ["startIndex": 0, "numberOfPosts": 10, "organizationObjectId": organization.objectId!]
        PFCloud.callFunctionInBackground("getPostsOfOrganizationInRange", withParameters: parameters as [NSObject : AnyObject]) {
            (results, error) -> Void in
            self.postTableViewManager.data = results as! [Post]
            tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func addData(refreshControl: UIRefreshControl, tableView: UITableView, startIndex: Int, numberOfPosts: Int) {
        let parameters: NSDictionary = ["startIndex": startIndex, "numberOfPosts": numberOfPosts, "organizationObjectId": organization.objectId!]
        PFCloud.callFunctionInBackground("getPostsOfOrganizationInRange", withParameters: parameters as [NSObject : AnyObject]) {
            (results, error) -> Void in
            for result in results as! [Post] {
                self.postTableViewManager.data.append(result)
            }
            tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func didScroll(scrollView: UIScrollView) {
        //        var contentOffset = scrollView.contentOffset.y
        //        if contentOffset >= 0 {
        //            var paralaxOffset = contentOffset / 2
        //            topViewContentOffset.constant = paralaxOffset
        //            tableViewTopConstraint.constant = 180-contentOffset
        //        }
    }
}
