//
//  Post.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/25/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import Foundation

class Post: PFObject, PFSubclassing {
    
    @NSManaged var organization: Organization
    @NSManaged var createUser: User
    @NSManaged var title: String
    @NSManaged var body: String
    @NSManaged var image: PFFile?
    @NSManaged var eventDate: NSDate
    @NSManaged var allowComments: Bool
    @NSManaged var notifyFollowers: Bool
    @NSManaged var notifyChildren: Bool
    @NSManaged var status: Bool
    @NSManaged var priority: Bool
    @NSManaged var postStartDate: NSDate
    @NSManaged var postEndDate: NSDate
    @NSManaged var commentsCount: Int
    
    override class func initialize() {
        super.initialize()
    }
    static func parseClassName() -> String {
        return "Post"
    }
}