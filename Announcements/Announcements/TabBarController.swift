//
//  TabBarController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/15/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var isDisplayingAdmin = false
    
    override func awakeFromNib() {
        self.tabBar.tintColor = UIColor.AccentColor()
        
    }
    
    override func viewDidLoad() {
        initializeTabBar()
    }
    
    func getAdmins() {
        PFCloud.callFunctionInBackground("getOrganizationsThatUserIsAdminOf", withParameters: nil) {
            (results, error) -> Void in
            if let followers = results as? [Follower] {
                var organizations: [Organization] = []
                for follower in followers {
                    organizations.append(follower.organization)
                }
                if organizations.count > 0 {
                    self.displayAdmin(organizations)
                }
            }
        }
    }
    
    func initializeTabBar() {
        viewControllers = []
        let today = Utilities.getViewControllerWithStoryboardIdentifier("Today", parentViewController: self)
        let discover = Utilities.getViewControllerWithStoryboardIdentifier("Discover", parentViewController: self)
        let me = Utilities.getViewControllerWithStoryboardIdentifier("User", parentViewController: self)
        let navigationController = Utilities.getViewControllerWithStoryboardIdentifier("NavigationController", parentViewController: self) as! UINavigationController
        navigationController.pushViewController(me, animated: false)
        let more = Utilities.getViewControllerWithStoryboardIdentifier("More", parentViewController: self)
        
        var controllers: Array<UIViewController> = []
        controllers.append(today)
        controllers.append(discover)
        controllers.append(navigationController)
        controllers.append(more)
        setViewControllers(controllers, animated: false)
        
        today.tabBarItem = UITabBarItem(title: "Today", image: UIImage(named: "Today"), tag: 0)
        discover.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(named: "Treasure Map"), tag: 1)
        navigationController.tabBarItem = UITabBarItem(title: "You", image: UIImage(named: "Me"), tag: 2)
        more.tabBarItem = UITabBarItem(title: "More", image: UIImage(named: "more"), tag: 1)
        
        getAdmins()
    }
    
    func setupTabBar() {
        var controllers = viewControllers!
        let more = controllers[2]
        
        let me = Utilities.getViewControllerWithStoryboardIdentifier("User", parentViewController: self)
        let navigationController = Utilities.getViewControllerWithStoryboardIdentifier("NavigationController", parentViewController: self) as! UINavigationController
        navigationController.pushViewController(me, animated: false)
        
        controllers[2] = navigationController
        controllers.append(more)
        
        setViewControllers(controllers, animated: false)
        
        navigationController.tabBarItem = UITabBarItem(title: "You", image: UIImage(named: "Me"), tag: 4)
    }
    
    func displayAdmin(organizations: [Organization]) {
        var controllers = viewControllers!
        let more = controllers[3]
        
        let admin = Utilities.getViewControllerWithStoryboardIdentifier("Admin", parentViewController: self) as! UINavigationController
        (admin.childViewControllers[0] as! AdminCollectionViewController).organizations = organizations
        controllers[3] = admin
        controllers.append(more)
        
        setViewControllers(controllers, animated: true)
        admin.tabBarItem = UITabBarItem(title: "Admin", image: UIImage(named: "Admin"), tag: 5)
    }
}
