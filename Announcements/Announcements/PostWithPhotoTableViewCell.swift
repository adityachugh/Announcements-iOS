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
    @IBOutlet weak var organizationImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var postContentTextView: UITextView!
    @IBOutlet weak var postCommentsCountLabel: UILabel!
    
    var parentViewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        organizationImageView.layer.masksToBounds = true;
        organizationImageView.layer.cornerRadius = organizationImageView.frame.height/2
        self.postContentTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    @IBAction func shareButtonTapped(sender: UIButton) {
        println("Share Tapped!")
    }
    
    @IBAction func commentButtonTapped(sender: UIButton) {
        println("Comment Tapped!")
    }
    
    @IBAction func organizationProfilePictureTapped(sender: UIButton) {
        Utilities.presentViewControllerVithStoryboardIdentifier("Organization", parentViewController: parentViewController)
    }
}
