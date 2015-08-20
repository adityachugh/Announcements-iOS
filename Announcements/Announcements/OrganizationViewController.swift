//
//  OrganizationViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/14/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class OrganizationViewController: UIViewController, PostTableViewScrollingDelegate {
    
    @IBOutlet weak var organizationFollowCountLabel: UILabel!
    @IBOutlet weak var organizationProfilePictureImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var organizationHandleLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    var postTableViewManager: PostTableViewManager!
    
    override func viewDidLoad() {
        postTableViewManager = PostTableViewManager(tableView: tableView, parentViewController: self)
        postTableViewManager.scrollingDelegate = self
        
        organizationProfilePictureImageView.layer.cornerRadius = organizationProfilePictureImageView.frame.size.height/2
        organizationProfilePictureImageView.layer.masksToBounds = true
    }
    
    @IBOutlet weak var topViewContentOffset: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    
    func didScroll(scrollView: UIScrollView) {
//        var contentOffset = scrollView.contentOffset.y
//        if contentOffset >= 0 {
//            var paralaxOffset = contentOffset / 2
//            topViewContentOffset.constant = paralaxOffset
//            tableViewTopConstraint.constant = 180-contentOffset
//        }
    }
}
