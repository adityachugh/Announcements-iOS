//
//  Organization.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/26/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import Foundation

class Organization: PFObject, PFSubclassing {
    
    @NSManaged var address: PFObject
    @NSManaged var allowComments: Bool
    @NSManaged var childCount: Int
    @NSManaged var config: PFObject
    @NSManaged var createUser: PFUser
    @NSManaged var organizationDescription: String
    @NSManaged var followerCount: Int
    @NSManaged var handle: String
    @NSManaged var image: PFFile?
    @NSManaged var coverPhoto: PFFile?
    @NSManaged var isTopLevel: Bool
    @NSManaged var name: String
    @NSManaged var parent: Organization
    @NSManaged var parentApprovalRequired: Bool
    @NSManaged var status: String
    @NSManaged var organizationType: String
    @NSManaged var parentLevelConfig: OrganizationLevelsConfig?
    @NSManaged var childLevelConfig: OrganizationLevelsConfig?
    @NSManaged var levelConfig: OrganizationLevelsConfig
    @NSManaged var hasAccessCode: Bool
    @NSManaged var accessCode: Int
    
    
    override class func initialize() {
        super.initialize()
    }
    static func parseClassName() -> String {
        return "Organization"
    }
}