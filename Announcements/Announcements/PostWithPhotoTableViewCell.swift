//
//  PostWithPhotoTableViewCell.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/13/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit
import ParseUI

class PostWithPhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var organizationImageView: PFImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var postContentTextView: UITextView!
    @IBOutlet weak var postCommentsCountLabel: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    
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
        Utilities.presentViewControllerVithStoryboardIdentifier("Comments", parentViewController: parentViewController) { (toViewController) -> UIViewController in
            return toViewController
        }
    }
    
    @IBAction func organizationProfilePictureTapped(sender: UIButton) {
        Utilities.presentViewControllerVithStoryboardIdentifier("Organization", parentViewController: parentViewController) { (toViewController) -> UIViewController in
            return toViewController
        }
    }
}
