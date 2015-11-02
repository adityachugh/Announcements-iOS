//
//  OrganizationCollectionViewCell.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/18/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

@IBDesignable class OrganizationCollectionViewCell: UICollectionViewCell {
    
    var organization: Organization! {
        didSet {
            organizationNameLabel.text = organization.name
            if let imageFile = organization.image {
                organizationProfilePictureImageView.file = imageFile
                organizationProfilePictureImageView.loadInBackground({ (image, error) -> Void in })
            } else {
                organizationProfilePictureImageView.image = UIImage(named: "placeholder_profile_pic")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        organizationProfilePictureImageView.layer.cornerRadius = organizationProfilePictureImageView.frame.width/2
        organizationProfilePictureImageView.layer.masksToBounds = true
        
//        followButton.hidden = true
//        
//        followButton.backgroundColor = UIColor.clearColor()
//        followButton.layer.cornerRadius = followButton.frame.size.height/2
//        followButton.layer.borderWidth = 2
//        followButton.layer.borderColor = UIColor.AccentColor().CGColor
    }
    
    @IBOutlet var organizationProfilePictureImageView: PFImageView!
    @IBOutlet weak var organizationNameLabel: UILabel!
//    @IBOutlet weak var followButton: FollowButton!
}