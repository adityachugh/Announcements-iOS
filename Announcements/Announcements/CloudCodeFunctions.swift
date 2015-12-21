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
    
}