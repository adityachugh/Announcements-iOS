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
        organizationImageView.layer.masksToBounds = true;
        organizationImageView.layer.cornerRadius = organizationImageView.frame.height/2
        
//        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).CGColor
//        contentView.layer.shadowRadius = 8
//        contentView.layer.shadowOpacity = 0.1
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
    
    
    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
