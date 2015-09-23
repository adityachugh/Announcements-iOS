//
//  CommentTableViewCell.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/19/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    var comment: Comment! {
        didSet {
            if let profilePhotoFile = comment.createUser.profilePhoto {
                userProfilePictureImageView.file = profilePhotoFile
                userProfilePictureImageView.loadInBackground({
                    (image, error) -> Void in
                    
                })
            }
            userNameLabel.text = "\(comment.createUser.firstName) \(comment.createUser.lastName)"
            timeLabel.text = comment.createdAt?.timeAgoSinceNow()
            commentTextView.text = comment.comment
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    // Initialization code
        commentTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        commentTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        userProfilePictureImageView.layer.cornerRadius = userProfilePictureImageView.frame.size.width/2
        userProfilePictureImageView.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var userProfilePictureImageView: PFImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    var parentViewController: UIViewController!
    
    @IBAction func userProfilePictureButtonTapped(sender: AnyObject) {
        Utilities.presentViewControllerVithStoryboardIdentifier("User", parentViewController: parentViewController) {
            (toViewController) -> UIViewController in
            let viewController = toViewController as! UserViewController
            viewController.user = self.comment.createUser
            return viewController
        }
    }
    
}