//
//  TabBarController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/15/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func awakeFromNib() {
        self.tabBar.tintColor = UIColor.AccentColor()
    }
    
    override func viewDidLoad() {
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
}
