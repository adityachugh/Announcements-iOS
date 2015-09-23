//
//  PostTableViewCell.swift
//  Announcements
//
//  Created by Aditya Chugh on 8/7/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit
//import ParseUI

class PostTableViewCell: UITableViewCell {
    
    var post: Post! {
        didSet {
            self.postContentTextView.text = post.body
            self.postTitleLabel.text = post.title
            self.postCommentsCountLabel.text = "\(post.commentsCount)"
            self.organizationNameLabel.text =  post.organization.name
            self.timeLabel.text = post.postStartDate.timeAgoSinceNow()
            if let organizationImageFile = post.organization.image {
                self.organizationImageView.file = organizationImageFile
                self.organizationImageView.loadInBackground({
                    (image, error) -> Void in
                    
                })
            }
            
        }
    }
    @IBOutlet weak var organizationImageView: PFImageView!
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var postContentTextView: UITextView!
    @IBOutlet weak var postCommentsCountLabel: UILabel!
    
    var parentViewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    deinit {
        print("Deinit \(self.post)")
    }
    
    func setup() {
        self.backgroundColor = UIColor.clearColor()
        organizationImageView.layer.masksToBounds = true;
        organizationImageView.layer.cornerRadius = organizationImageView.frame.height/2
        
        self.postContentTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.postContentTextView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
    }
    
    @IBAction func shareButtonTapped(sender: UIButton) {
        print("Share Tapped!")
    }
    
    @IBAction func commentButtonTapped(sender: UIButton) {
        if let parentVC = parentViewController as? CommentsTableViewController {
            Utilities.presentViewControllerModallyVithStoryboardIdentifier("TextViewController", parentViewController: parentVC) {
                (toViewController) -> UIViewController in
                let viewController = toViewController as! TextViewController
                viewController.delegate = parentVC
                viewController.maxCharacterCount = 1000
                return viewController
            }

        } else {
            Utilities.presentViewControllerVithStoryboardIdentifier("Comments", parentViewController: parentViewController) { (toViewController) -> UIViewController in
                let viewController = toViewController as! CommentsTableViewController
                viewController.post = self.post
                print("CommentTableView creation: \(viewController.post)")
                return viewController
            }
        }
    }
    
    @IBAction func organizationProfilePictureTapped(sender: UIButton) {
        if !parentViewController.isKindOfClass(OrganizationViewController) {
            Utilities.presentViewControllerVithStoryboardIdentifier("Organization", parentViewController: parentViewController) { (toViewController) -> UIViewController in
                let viewController = toViewController as! OrganizationViewController
                viewController.organization = self.post.organization
                return viewController
            }
        }
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        //        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
