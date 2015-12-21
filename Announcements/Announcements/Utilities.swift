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
        var viewController = parentViewController.storyboard!.instantiateViewControllerWithIdentifier(identifier)
        
        viewController = modifications(toViewController: viewController)
        parentViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    class func isValidEmail(testStr:String?) -> Bool {
        if testStr != nil {
            let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluateWithObject(testStr)
        }
        return false
    }
    
    class func presentViewControllerModallyVithStoryboardIdentifier(identifier: String, parentViewController: UIViewController, modifications:((toViewController: UIViewController) -> UIViewController)) {
        var viewController = parentViewController.storyboard!.instantiateViewControllerWithIdentifier(identifier)
        
        if #available(iOS 8.0, *) {
            viewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        } else {
            parentViewController.tabBarController?.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        }
        
        viewController = modifications(toViewController: viewController)
        if let tabBarController = parentViewController as? UITabBarController {
            tabBarController.presentViewController(viewController, animated: false, completion: nil)
        } else {
            parentViewController.tabBarController?.presentViewController(viewController, animated: false, completion: nil)
        }
        
    }
    
    class func getViewControllerWithStoryboardIdentifier(identifier: String, parentViewController: UIViewController) -> UIViewController {
        return parentViewController.storyboard!.instantiateViewControllerWithIdentifier(identifier)
    }
    
    class func calculcateHeightForPostCell(view:UIView, bodyText:String, finalModification:(height:CGFloat)->(CGFloat)) -> CGFloat {
        let calculationBodyView = UITextView()
        calculationBodyView.attributedText = NSAttributedString(string: bodyText)
        calculationBodyView.font = UIFont(name: "AvenirNext-Regular", size: 12.5)
        calculationBodyView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        //        calculationBodyView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        var size:CGSize = CGSize()
        size = calculationBodyView.sizeThatFits(CGSize(width: view.frame.width-16, height: CGFloat.max))
        let height = finalModification(height: size.height)
        return height
    }
    
    class func animate(animations:(() -> ())) {
        UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
            () -> Void in
            animations()
            }, completion: nil)
    }
    
    class func animateWithCompletion(animations:(() -> ()), completion:(() -> ())) {
        UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
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
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
}

public extension UIImage {
    func resize(scale:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width*scale, height: size.height*scale)))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    func resizeToWidth(width:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
