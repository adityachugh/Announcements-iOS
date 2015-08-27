//
//  Utilities.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/13/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class Utilities {
    
    static let iOS7 = floor(NSFoundationVersionNumber) <= floor(NSFoundationVersionNumber_iOS_7_1)
    static let iOS8 = floor(NSFoundationVersionNumber) > floor(NSFoundationVersionNumber_iOS_7_1)
    
    class func presentViewControllerVithStoryboardIdentifier(identifier: String, parentViewController: UIViewController, modifications:((toViewController: UIViewController) -> UIViewController)) {
        var viewController = parentViewController.storyboard!.instantiateViewControllerWithIdentifier(identifier) as! UIViewController
        
        viewController = modifications(toViewController: viewController)
        parentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    class func presentViewControllerModallyVithStoryboardIdentifier(identifier: String, parentViewController: UIViewController, modifications:((toViewController: UIViewController) -> UIViewController)) {
        var viewController = parentViewController.storyboard!.instantiateViewControllerWithIdentifier(identifier) as! UIViewController
        if iOS8 {
            viewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        } else {
            viewController.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        }
        viewController = modifications(toViewController: viewController)
        parentViewController.tabBarController?.presentViewController(viewController, animated: false, completion: nil)
    }
    
    class func calculcateHeightForPostCell(view:UIView, bodyText:String, finalModification:(height:CGFloat)->(CGFloat)) -> CGFloat {
        var calculationBodyView = UITextView()
        calculationBodyView.attributedText = NSAttributedString(string: bodyText)
        calculationBodyView.font = UIFont(name: "AvenirNext-Regular", size: 12.5)
        calculationBodyView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        //        calculationBodyView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        var size:CGSize = CGSize()
        size = calculationBodyView.sizeThatFits(CGSize(width: view.frame.width-16, height: CGFloat.max))
        var height = finalModification(height: size.height)
        return height
    }
    
    class func animate(animations:(() -> ())) {
        UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: nil, animations: {
            () -> Void in
            animations()
            }, completion: nil)
    }
    
    class func animateWithCompletion(animations:(() -> ()), completion:(() -> ())) {
        UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: nil, animations: {
            () -> Void in
            animations()
            }, completion: {
                (completed) -> Void in
                completion()
        })
    }
    
    class func delayTime(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}

public extension UIWindow {
    
    func capture() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, self.opaque, 0.0)
        self.layer.renderInContext(UIGraphicsGetCurrentContext())
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}