//
//  ViewController.swift
//  CloudFunctionTest
//
//  Created by Aditya Chugh on 7/27/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        PFCloud.callFunctionInBackground("hello", withParameters: nil) {
//            (res, error) -> Void in
//            println(res as! String)
//        }
    
//        PFUser.logInWithUsername("chughrajiv", password: "password")
        
        var dictionary = ["startIndex":0, "numberOfPosts": 1, "date": NSDate()]
        PFCloud.callFunctionInBackground("getRangeOfPostsForDay", withParameters: nil) {
            (res, error) -> Void in
            if (error != nil) {
                println((error!).description)
            } else {
                println(res as! [PFObject])
            }
        }
    }
}