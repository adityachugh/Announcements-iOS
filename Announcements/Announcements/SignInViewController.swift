//
//  SignInViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 10/4/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

@IBDesignable

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var topOffset: NSLayoutConstraint!
    @IBOutlet weak var slantedView: SlantedView!
    
    var defaultPosition = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        signInButton.layer.cornerRadius = 20
        
        defaultPosition = slantedView.frame
        
    }
    
    
    
    @IBAction func signInTapped(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!) {
            (user, error) -> Void in
            if error == nil {
                if let viewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? TabBarController {
                    viewController.initializeTabBar()
                }
                self.navigationController?.dismissViewControllerAnimated(true, completion: {
                    () -> Void in
                    
                    
                })
            } else {
                RKDropdownAlert.title("Login Failed", message: "Invalid username or password!", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
            }
        }
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == usernameTextField {
            self.topOffset.constant = 105-225
            self.slantedView.setNeedsUpdateConstraints()
            Utilities.animate {
                () -> () in
                self.slantedView.layoutIfNeeded()
            }
        } else if textField == passwordTextField {
            self.topOffset.constant = 105-265
            self.slantedView.setNeedsUpdateConstraints()
            Utilities.animate {
                () -> () in
                self.slantedView.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        self.topOffset.constant = 105
        self.slantedView.setNeedsUpdateConstraints()
        Utilities.animate {
            () -> () in
            self.slantedView.layoutIfNeeded()
        }
    }
    
    @IBAction func viewPanned(sender: AnyObject) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        self.topOffset.constant = 105
        self.slantedView.setNeedsUpdateConstraints()
        Utilities.animate {
            () -> () in
            self.slantedView.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameTextField {
            usernameTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            return true
        } else {
            passwordTextField.resignFirstResponder()
            self.topOffset.constant = 105
            self.slantedView.setNeedsUpdateConstraints()
            Utilities.animate {
                () -> () in
                self.slantedView.layoutIfNeeded()
            }
            return false
        }
        
    }
    
}
