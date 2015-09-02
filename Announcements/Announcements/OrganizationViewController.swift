//
//  OrganizationViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/14/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class OrganizationViewController: UIViewController, PostTableViewScrollingDelegate, RefreshDelegate {
    
    @IBOutlet weak var organizationFollowCountLabel: UILabel!
    @IBOutlet weak var organizationProfilePictureImageView: PFImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var organizationHandleLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    var postTableViewManager: PostTableViewManager!
    var organization: Organization!
    
    override func viewDidLoad() {
        postTableViewManager = PostTableViewManager(tableView: tableView, parentViewController: self, refreshDelegate: self)
        postTableViewManager.scrollingDelegate = self
        
        organizationProfilePictureImageView.layer.cornerRadius = organizationProfilePictureImageView.frame.size.height/2
        organizationProfilePictureImageView.layer.masksToBounds = true
        
        organizationProfilePictureImageView.file = organization.image
        title = organization.name
        organizationHandleLabel.text = "@\(organization.handle)"
        organizationFollowCountLabel.text = "\(organization.followerCount) Followers"
    }
    
    @IBOutlet weak var topViewContentOffset: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    func refreshData(refreshControl: UIRefreshControl, tableView: UITableView) {
        var parameters: NSDictionary = ["startIndex": 0, "numberOfPosts": 10, "organizationObjectId": organization.objectId!]
        PFCloud.callFunctionInBackground("getPostsOfOrganizationInRange", withParameters: parameters as [NSObject : AnyObject]) {
            (results, error) -> Void in
            self.postTableViewManager.data = results as! [Post]
            tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func addData(refreshControl: UIRefreshControl, tableView: UITableView, startIndex: Int, numberOfPosts: Int) {
        var parameters: NSDictionary = ["startIndex": startIndex, "numberOfPosts": numberOfPosts, "organizationObjectId": organization.objectId!]
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
