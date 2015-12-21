//
//  OrganizationLevelsConfig.swift
//  infor[me]
//
//  Created by Aditya Chugh on 11/22/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import Foundation

class OrganizationLevelsConfig: PFObject, PFSubclassing {
    
    @NSManaged var createUser: User
    @NSManaged var parent: OrganizationLevelsConfig
    @NSManaged var levelNumber: Int
    @NSManaged var levelName: String
    
    override class func initialize() {
        super.initialize()
    }
    static func parseClassName() -> String {
        return "OrganizationLevelsConfig"
    }
}