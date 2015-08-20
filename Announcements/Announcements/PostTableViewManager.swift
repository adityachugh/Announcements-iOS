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
    var parentViewController: UIViewController!
    var tableView: UITableView!
    
    init(tableView: UITableView, parentViewController: UIViewController) {
        self.tableView = tableView
        self.parentViewController = parentViewController
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //Register Nibs
        self.tableView.registerNib(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "Post")
        self.tableView.registerNib(UINib(nibName: "PostWithPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PostWithPhoto")
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
    }
    
    var content = ["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here. ", "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet.", "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet.", "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet."]
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Utilities.calculcateHeightForPostCell(tableView, bodyText: content[indexPath.row]) {
            (height) -> (CGFloat) in
            if indexPath.row == 2 {
                return height + 247
            }
            return height + 89
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollingDelegate?.didScroll(scrollView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("PostWithPhoto") as! PostWithPhotoTableViewCell
            
            cell.postContentTextView.text = content[indexPath.row]
            cell.parentViewController = parentViewController
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Post") as! PostTableViewCell
        
        cell.postContentTextView.text = content[indexPath.row]
        cell.parentViewController = parentViewController
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
