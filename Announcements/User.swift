//
//  User.swift
//  infor[me]
//
//  Created by Aditya Chugh on 9/1/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import Foundation

class User: PFUser {
    
    @NSManaged var commentsCreatedCount: Organization
    @NSManaged var profilePhoto: PFFile?
    @NSManaged var coverPhoto: PFFile?
    @NSManaged var userDescription: String
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var lastLoginDate: NSDate
    @NSManaged var notifyByEmail: Bool
    @NSManaged var organizationsFollowedCount: Int
    @NSManaged var postsViewedCount: Int
    
    override class func initialize() {
        super.initialize()
    }
}