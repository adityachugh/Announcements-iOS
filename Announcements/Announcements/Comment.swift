//
//  Comment.swift
//  infor[me]
//
//  Created by Aditya Chugh on 9/1/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import Foundation

class Comment: PFObject, PFSubclassing {
    
    @NSManaged var post: Post
    @NSManaged var createUser: User
    @NSManaged var comment: String
    @NSManaged var isDeleted: Bool
    
    override class func initialize() {
        super.initialize()
    }
    static func parseClassName() -> String {
        return "Comments"
    }
}