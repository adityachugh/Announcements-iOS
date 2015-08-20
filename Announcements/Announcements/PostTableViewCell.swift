//
//  PostTableViewCell.swift
//  Announcements
//
//  Created by Aditya Chugh on 8/7/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var organizationImageView: UIImageView!
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
    
    func setup() {
        self.backgroundColor = UIColor.clearColor()
        organizationImageView.layer.masksToBounds = true;
        organizationImageView.layer.cornerRadius = organizationImageView.frame.height/2
        
        self.postContentTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.postContentTextView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
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
    
    
    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
