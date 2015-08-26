//
//  AppDelegate.swift
//  Announcements
//
//  Created by Aditya Chugh on 7/13/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        
        Parse.setApplicationId("S1dL5D6QCSqsC1FyYTiyS5V4Yv2zcK47TeybVtEf",
            clientKey: "llxS4kjhRdSv46DvGi9HyPapsRaFDoU9155Nh88V")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        application.setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        setupBarButtonItemFont()
        
        if PFUser.currentUser() == nil {
            PFUser.logInWithUsernameInBackground("chughrajiv", password: "password") {
                (user, error) -> Void in
                println("User Logged In!")
            }
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func setupBarButtonItemFont() {
        var dictionary = [NSFontAttributeName as NSObject: UIFont(name: "AvenirNext-Regular", size: 19) as! AnyObject]
        UIBarButtonItem.appearance().setTitleTextAttributes(dictionary, forState: UIControlState.Normal)
    }

}

