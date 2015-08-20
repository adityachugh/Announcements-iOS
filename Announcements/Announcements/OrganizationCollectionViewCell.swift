//
//  OrganizationCollectionViewCell.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/18/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

@IBDesignable class OrganizationCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        organizationProfilePictureImageView.layer.cornerRadius = organizationProfilePictureImageView.frame.width/2
        organizationProfilePictureImageView.layer.masksToBounds = true
        
        followButton.backgroundColor = UIColor.clearColor()
        followButton.layer.cornerRadius = followButton.frame.size.height/2
        followButton.layer.borderWidth = 2
        followButton.layer.borderColor = UIColor.AccentColor().CGColor
    }
    
    @IBOutlet var organizationProfilePictureImageView: UIImageView!
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var followButton: FollowButton!
}