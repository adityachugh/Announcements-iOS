//
//  PostTableViewManager.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/14/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit
//import Parse

class PostTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var scrollingDelegate: PostTableViewScrollingDelegate?
    var refreshDelegate: PostTableViewRefreshDelegate?
    var parentViewController: UIViewController!
    var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var bottomRefreshControl = UIRefreshControl()
    var data:[Post] = []
    
    init(tableView: UITableView, parentViewController: UIViewController, refreshDelegate: PostTableViewRefreshDelegate) {
        self.tableView = tableView
        self.parentViewController = parentViewController
        self.refreshDelegate = refreshDelegate
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //Register Nibs
        self.tableView.registerNib(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "Post")
        self.tableView.registerNib(UINib(nibName: "PostWithPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PostWithPhoto")
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: "refreshTop", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.beginRefreshing()
        refreshTop()
        
        tableView.bottomRefreshControl = bottomRefreshControl
        bottomRefreshControl.addTarget(self, action: "refreshBottom", forControlEvents: UIControlEvents.ValueChanged)
        bottomRefreshControl.triggerVerticalOffset = 50
    }
    
    func refreshTop() {
        refreshControl.beginRefreshing()
        refreshDelegate?.refreshData(refreshControl, tableView: tableView)
    }
    
    func refreshBottom() {
        println("Bottom")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Utilities.calculcateHeightForPostCell(tableView, bodyText: data[indexPath.row].body) {
            (height) -> (CGFloat) in
            if let imageFile = self.data[indexPath.row].image {
                return height + 247
            }
            return height + 89
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollingDelegate?.didScroll(scrollView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let imageFile = data[indexPath.row].image {
            let cell = tableView.dequeueReusableCellWithIdentifier("PostWithPhoto") as! PostWithPhotoTableViewCell
            cell.postImageView.file = imageFile
            cell.postImageView.loadInBackground({
                (image, error) -> Void in
                
            })
            cell.postContentTextView.text = data[indexPath.row].body
            cell.postTitleLabel.text = data[indexPath.row].title
            cell.parentViewController = parentViewController
            cell.postCommentsCountLabel.text = "\(data[indexPath.row].commentsCount)"
            cell.organizationNameLabel.text =  data[indexPath.row].organization.name
            if let organizationImageFile = data[indexPath.row].organization.image {
                cell.organizationImageView.file = organizationImageFile
                cell.organizationImageView.loadInBackground({
                    (image, error) -> Void in
                    
                })
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Post") as! PostTableViewCell
        
        cell.postContentTextView.text = data[indexPath.row].body
        cell.postTitleLabel.text = data[indexPath.row].title
        cell.postCommentsCountLabel.text = "\(data[indexPath.row].commentsCount)"
        cell.parentViewController = parentViewController
        cell.organizationNameLabel.text =  data[indexPath.row].organization.name
        if let organizationImageFile = data[indexPath.row].organization.image {
            cell.organizationImageView.file = organizationImageFile
            cell.organizationImageView.loadInBackground({
                (image, error) -> Void in
                
            })
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        Utilities.presentViewControllerVithStoryboardIdentifier("Comments", parentViewController: parentViewController) { (toViewController) -> UIViewController in
            return toViewController
        }
    }
}

protocol PostTableViewScrollingDelegate {
    func didScroll(scrollView: UIScrollView)
}

protocol PostTableViewRefreshDelegate {
    func refreshData(refreshControl: UIRefreshControl, tableView: UITableView)
    func addData()
}
