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
        
        PFCloud.callFunctionInBackground("hello", withParameters: nil) {
            (res, error) -> Void in
            println(res as! String)
        }
        
        var dictionary = ["name":"Aditya", "age":11]
        PFCloud.callFunctionInBackground("testWithParameters", withParameters: dictionary) {
            (res, error) -> Void in
            println(res as! String)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}