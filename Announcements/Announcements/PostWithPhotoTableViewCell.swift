//
//  PostWithPhotoTableViewCell.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/13/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class PostWithPhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var organizationImageView: PFImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var postContentTextView: UITextView!
    @IBOutlet weak var postCommentsCountLabel: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    var post: Post! {
        didSet {
            self.postImageView.file = post.image
            self.postImageView.loadInBackground({ (image, error) -> Void in })
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
    
    deinit {
        println("Deinit \(self.post)")
    }
    
    var parentViewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        self.backgroundColor = UIColor.clearColor()
        organizationImageView.layer.masksToBounds = true;
        organizationImageView.layer.cornerRadius = organizationImageView.frame.height/2
        self.postContentTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    @IBAction func shareButtonTapped(sender: UIButton) {
        println("Share Tapped!")
    }
    
    @IBAction func commentButtonTapped(sender: UIButton) {
        if let viewController = parentViewController as? CommentsTableViewController {
            
        } else {
            Utilities.presentViewControllerVithStoryboardIdentifier("Comments", parentViewController: parentViewController) { (toViewController) -> UIViewController in
                var viewController = toViewController as! CommentsTableViewController
                viewController.post = self.post
                return viewController
            }
        }
        

    }
    
    @IBAction func organizationProfilePictureTapped(sender: UIButton) {
        if !parentViewController.isKindOfClass(OrganizationViewController) {
            Utilities.presentViewControllerVithStoryboardIdentifier("Organization", parentViewController: parentViewController) { (toViewController) -> UIViewController in
                var viewController = toViewController as! OrganizationViewController
                viewController.organization = self.post.organization
                return viewController
            }
        }
    }
}
