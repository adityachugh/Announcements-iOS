//
//  PostTableViewManager.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/14/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class PostTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var scrollingDelegate: PostTableViewScrollingDelegate?
    var refreshDelegate: RefreshDelegate?
    var parentViewController: UIViewController!
    var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var bottomRefreshControl = UIRefreshControl()
    
    var data:[Post] = []
    var startIndex = 0
    var numberOfPosts = 10
    
    init(tableView: UITableView, parentViewController: UIViewController, refreshDelegate: RefreshDelegate) {
        self.tableView = tableView
        self.parentViewController = parentViewController
        self.refreshDelegate = refreshDelegate
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        registerNibs()
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: "refreshTop", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.beginRefreshing()
        refreshTop()
        
        tableView.bottomRefreshControl = bottomRefreshControl
        bottomRefreshControl.addTarget(self, action: "refreshBottom", forControlEvents: UIControlEvents.ValueChanged)
        bottomRefreshControl.triggerVerticalOffset = 80
    }
    
    func registerNibs() {
        tableView.registerNib(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "Post")
        tableView.registerNib(UINib(nibName: "PostWithPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PostWithPhoto")
        
        
    }
    
    func refreshTop() {
        startIndex = 0
        refreshControl.beginRefreshing()
        refreshDelegate?.refreshData(refreshControl, tableView: tableView)
    }
    
    func refreshBottom() {
        bottomRefreshControl.beginRefreshing()
        startIndex = data.count
        refreshDelegate?.addData(bottomRefreshControl, tableView: tableView, startIndex: startIndex, numberOfPosts: numberOfPosts)
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
            cell.post = data[indexPath.row]
            cell.parentViewController = parentViewController

            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Post") as! PostTableViewCell

        cell.post = data[indexPath.row]
        cell.parentViewController = parentViewController
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        Utilities.presentViewControllerVithStoryboardIdentifier("Comments", parentViewController: parentViewController) { (toViewController) -> UIViewController in
            var viewController = toViewController as! CommentsTableViewController
            viewController.post = self.data[indexPath.row]
            return viewController
        }
    }
}

protocol PostTableViewScrollingDelegate {
    func didScroll(scrollView: UIScrollView)
}

protocol RefreshDelegate {
    func refreshData(refreshControl: UIRefreshControl, tableView: UITableView)
    func addData(refreshControl: UIRefreshControl, tableView: UITableView, startIndex: Int, numberOfPosts: Int)
}