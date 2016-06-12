//
//  CloudCodeFunctions.swift
//  infor[me]
//
//  Created by Aditya Chugh on 11/23/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import Foundation

class CloudCodeFunctions {
    
    static func updateOrganizationFields(organizationObjectId: String, description: String, name: String, hasAccessCode: Bool, accessCode: Int?, organizationType: String, completion: (Organization?, NSError?)->()) {
        var parameters: Dictionary<String, AnyObject> = ["organizationObjectId": organizationObjectId, "description": description, "name": name, "hasAccessCode": hasAccessCode, "organizationType": organizationType]
        if let ac = accessCode {
            parameters["accessCode"] = ac
        }
        PFCloud.callFunctionInBackground("updateOrganizationFields", withParameters: parameters) {
            (result, error) -> Void in
            completion(result as! Organization?, error)
        }

    }
    
    static func getFollowersForOrganizationInRange(organizationObjectId: String, startIndex: Int, numberOfUsers: Int, completion: ([Follower]?, NSError?)->()) {
        let parameters: Dictionary<String, AnyObject> = ["organizationObjectId": organizationObjectId, "startIndex": startIndex, "numberOfUsers": numberOfUsers]
        PFCloud.callFunctionInBackground("getFollowersForOrganizationInRange", withParameters: parameters) {
            (result, error) -> Void in
            completion(result as! [Follower]?, error)
        }
    }
    
    static func removeFollowerFromOrganization(organizationObjectId: String, selectedFollowerToRemoveObjectId: String, completion: (Bool?, NSError?)->()) {
        let parameters: Dictionary<String, AnyObject> = ["organizationObjectId": organizationObjectId, "selectedFollowerToRemoveObjectId": selectedFollowerToRemoveObjectId]
        PFCloud.callFunctionInBackground("removeFollowerFromOrganization", withParameters: parameters) {
            (result, error) -> Void in
            completion(result as! Bool?, error)
        }
    }
}