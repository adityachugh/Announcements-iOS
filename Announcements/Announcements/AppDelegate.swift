//
//  AppDelegate.swift
//  Announcements
//
//  Created by Aditya Chugh on 7/13/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        
        Parse.setApplicationId("S1dL5D6QCSqsC1FyYTiyS5V4Yv2zcK47TeybVtEf",
            clientKey: "llxS4kjhRdSv46DvGi9HyPapsRaFDoU9155Nh88V")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        
        application.setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        setupBarButtonItemFont()
        
        //Register subclasses
        
        Post.registerSubclass()
        Organization.registerSubclass()
        Comment.registerSubclass()
        User.registerSubclass()
        Follower.registerSubclass()
        OrganizationLevelsConfig.registerSubclass()

//        if let rootViewController = window?.rootViewController {
//            Utilities.presentViewControllerModallyVithStoryboardIdentifier("DatePicker", parentViewController: rootViewController) { (toViewController) -> UIViewController in
//                let datePickerViewController = toViewController
//                
//                return datePickerViewController
//            }
//        }
        
//
        displayOnboarding(false)
        
        
        // Register for Push Notitications
        if application.applicationState != UIApplicationState.Background {
            // Track an app open here if we launch with a push, unless
            // "content_available" was used to trigger a background push (introduced in iOS 7).
            // In that case, we skip tracking here to avoid double counting the app-open.
            
            let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
            let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
            var pushPayload = false
            if let options = launchOptions {
                pushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil
            }
            if (preBackgroundPush || oldPushHandlerOnly || pushPayload) {
                PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
            }
        }
        if application.respondsToSelector("registerUserNotificationSettings:") {
            
            
            if #available(iOS 8.0, *) {
                let userNotificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
                let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
                application.registerUserNotificationSettings(settings)
                application.registerForRemoteNotifications()
                
            } else {
                // Fallback on earlier versions
            }
        } else {
            let types: UIRemoteNotificationType = [UIRemoteNotificationType.Badge, UIRemoteNotificationType.Alert, UIRemoteNotificationType.Sound]
            application.registerForRemoteNotificationTypes(types)
        }
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
        return true
    }
    
    func displayOnboarding(animated: Bool) {
        if PFUser.currentUser() == nil {
            if let parentViewController = window?.rootViewController {
                window!.makeKeyAndVisible()
                let viewController = parentViewController.storyboard!.instantiateViewControllerWithIdentifier("Onboarding")
                parentViewController.presentViewController(viewController, animated: animated, completion: nil)
                
//                Utilities.presentViewControllerModallyVithStoryboardIdentifier("Onboarding", parentViewController: parentViewController, modifications: {
//                    (toViewController) -> UIViewController in
//                    return toViewController
//                }, animated: animated)
            }
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
        if application.applicationState == UIApplicationState.Inactive {
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
        }
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
        let dictionary = [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 19) as! AnyObject]
        UIBarButtonItem.appearance().setTitleTextAttributes(dictionary, forState: UIControlState.Normal)
    }
    
}

