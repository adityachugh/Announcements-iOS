//
//  UserTableViewCell.swift
//  infor[me]
//
//  Created by Aditya Chugh on 12/30/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePictureImageView: PFImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    var follower: Follower! {
        didSet {
            if let profilePhoto = follower.user.profilePhoto {
                profilePictureImageView.file = profilePhoto
                profilePictureImageView.loadInBackground()
            } else {
                profilePictureImageView.file = nil
                profilePictureImageView.image = nil
            }
            nameLabel.text = "\(follower.user.firstName) \(follower.user.lastName)"
            usernameLabel.text = "@\(follower.user.username!.lowercaseString)"
        }
    }
    var parentViewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePictureImageView.layer.masksToBounds = true
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.width/2
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            Utilities.presentViewControllerVithStoryboardIdentifier("User", parentViewController: parentViewController, modifications: {
                (toViewController) -> UIViewController in
                let viewController = toViewController as! UserViewController
                viewController.user = self.follower.user
                return viewController
            })
        }
    }
    
}
