//
//  Utilities.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/13/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class Utilities {
    
    class func presentViewControllerVithStoryboardIdentifier(identifier: String, parentViewController: UIViewController) {
        var viewController = parentViewController.storyboard!.instantiateViewControllerWithIdentifier(identifier) as! UIViewController
        parentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    class func calculcateHeightForPostCell(view:UIView, bodyText:String, finalModification:(height:CGFloat)->(CGFloat)) -> CGFloat {
        var calculationBodyView = UITextView()
        calculationBodyView.font = UIFont(name: "AvenirNext-Regular", size: 12.5)
        calculationBodyView.text = bodyText
        calculationBodyView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        var size:CGSize = CGSize()
        size = calculationBodyView.sizeThatFits(CGSize(width: view.frame.width-16, height: CGFloat.max))
        var height = finalModification(height: size.height)
        return height
    }
}