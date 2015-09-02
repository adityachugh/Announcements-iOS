//
//  Follower.swift
//  infor[me]
//
//  Created by Aditya Chugh on 9/2/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import Foundation

class Follower: PFObject, PFSubclassing {
    
    @NSManaged var organization: Organization
    @NSManaged var user: User
    
    override class func initialize() {
        super.initialize()
    }
    static func parseClassName() -> String {
        return "Followers"
    }
}