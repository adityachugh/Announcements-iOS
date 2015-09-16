//
//  CommentsTableViewManager.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/19/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class CommentsTableViewManager: PostTableViewManager {
    
    var post: Post!
    var comments: [Comment] = []
    
    override init(tableView: UITableView, parentViewController: UIViewController, refreshDelegate: RefreshDelegate) {
        super.init(tableView: tableView, parentViewController: parentViewController, refreshDelegate: refreshDelegate)
    }
    
    override func registerNibs() {
        tableView.registerNib(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "Post")
        tableView.registerNib(UINib(nibName: "PostWithPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PostWithPhoto")
        tableView.registerNib(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "Comment")
    }
    
    override func refreshTop() {
        startIndex = 0
        refreshControl.beginRefreshing()
        refreshDelegate?.refreshData(refreshControl, tableView: tableView)
    }
    
    override func refreshBottom() {
        bottomRefreshControl.beginRefreshing()
        startIndex = comments.count
        refreshDelegate?.addData(bottomRefreshControl, tableView: tableView, startIndex: startIndex, numberOfPosts: numberOfPosts)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0 {
            return 1
        }
        return comments.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        println("\(indexPath.section): \(indexPath.row)")
        if indexPath.section == 0 {
//            println("Comments: \(comments.count)")
//            println(post)
            
            return Utilities.calculcateHeightForPostCell(tableView, bodyText: post.body) {
                (height) -> (CGFloat) in
                if let imageFile = self.post.image {
                    return height + 247
                }
                return height + 89
            }
        }
        return Utilities.calculcateHeightForPostCell(tableView, bodyText: comments[indexPath.row].comment, finalModification: {
            (height) -> (CGFloat) in
            return height+56
        })
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            if let imageFile = post.image {
                let cell = tableView.dequeueReusableCellWithIdentifier("PostWithPhoto") as! PostWithPhotoTableViewCell
                cell.post = post
                cell.parentViewController = parentViewController
                
                return cell
            }
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Post") as! PostTableViewCell
            
            cell.post = post
            cell.parentViewController = parentViewController
            
            return cell
            
            //            if cell.respondsToSelector("setSeparatorInset:") {
            //                cell.separatorInset = UIEdgeInsetsZero
            //            }
            //            if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            //                cell.preservesSuperviewLayoutMargins = false
            //            }
            //            if cell.respondsToSelector("setLayoutMargins:") {
            //                cell.layoutMargins = UIEdgeInsetsZero
            //            }
            
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Comment", forIndexPath: indexPath) as! CommentTableViewCell
            cell.comment = comments[indexPath.row]
            cell.parentViewController = parentViewController
            
            //            if cell.respondsToSelector("setSeparatorInset:") {
            //                cell.separatorInset = UIEdgeInsetsZero
            //            }
            //            if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            //                cell.preservesSuperviewLayoutMargins = false
            //            }
            //            if cell.respondsToSelector("setLayoutMargins:") {
            //                cell.layoutMargins = UIEdgeInsetsZero
            //            }
            
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.selected = false
    }
    
}