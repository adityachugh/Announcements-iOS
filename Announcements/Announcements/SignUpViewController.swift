//
//  SignUpViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 10/13/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var usernameStatusIndicator: StatusIndicator!
    @IBOutlet weak var emailStatusIndicator: StatusIndicator!
    
    var fieldValidity = [false, false, false, false, false]
    var canSignUp: Bool {
        get {
            for var i = 0; i < fieldValidity.count; ++i {
                if fieldValidity[i] == false {
                    return false
                }
            }
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = 20
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        usernameStatusIndicator.backgroundColor = UIColor.clearColor()
        usernameStatusIndicator.status = StatusIndicator.Status.None
        emailStatusIndicator.backgroundColor = UIColor.clearColor()
        emailStatusIndicator.status = StatusIndicator.Status.None
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            firstNameTextField.resignFirstResponder()
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            lastNameTextField.resignFirstResponder()
            usernameTextField.becomeFirstResponder()
        } else if textField == usernameTextField {
            usernameTextField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == firstNameTextField {
            var text = firstNameTextField.text
            if text != nil && text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != "" {
                text = text?.lowercaseString
                text = text?.capitalizeFirst
                firstNameTextField.text = text
                fieldValidity[0] = true
            } else {
                fieldValidity[0] = false
                firstNameTextField.text = ""
            }
        } else if textField == lastNameTextField {
            var text = lastNameTextField.text
            if text != nil && text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != "" {
                text = text?.lowercaseString
                text = text?.capitalizeFirst
                lastNameTextField.text = text
                fieldValidity[1] = true
            } else {
                fieldValidity[1] = false
                lastNameTextField.text = ""
            }
        } else if textField == usernameTextField {
            var text = usernameTextField.text
            if text != nil && text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != "" {
                text = text?.lowercaseString
                usernameTextField.text = text
                usernameStatusIndicator.status = StatusIndicator.Status.Loading
                PFCloud.callFunctionInBackground("isUsernameInUse", withParameters: ["username" as NSObject: text as! AnyObject], block: {
                    (result, error) -> Void in
                    if error == nil {
                        if (result as! Bool) {
                            self.fieldValidity[2] = false
                            self.usernameStatusIndicator.status = StatusIndicator.Status.False
                        } else {
                            self.fieldValidity[2] = true
                            self.usernameStatusIndicator.status = StatusIndicator.Status.True
                        }
                    }
                })
            } else {
                fieldValidity[2] = false
                self.usernameStatusIndicator.status = StatusIndicator.Status.False
                usernameTextField.text = ""
            }
        } else if textField == emailTextField {
            var text = emailTextField.text
            if text != nil && text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != "" {
                if Utilities.isValidEmail(text) {
                    text = text?.lowercaseString
                    emailTextField.text = text
                    PFCloud.callFunctionInBackground("isEmailInUse", withParameters: ["email" as NSObject: text as! AnyObject], block: {
                        (result, error) -> Void in
                        if error == nil {
                            if (result as! Bool) {
                                self.fieldValidity[3] = false
                                self.emailStatusIndicator.status = StatusIndicator.Status.False
                            } else {
                                self.fieldValidity[3] = true
                                self.emailStatusIndicator.status = StatusIndicator.Status.True
                            }
                        }
                    })
                } else {
                    fieldValidity[3] = false
                    self.emailStatusIndicator.status = StatusIndicator.Status.False
                }
            } else {
                fieldValidity[3] = false
                self.emailStatusIndicator.status = StatusIndicator.Status.False
                emailTextField.text = ""
            }
        } else if textField == passwordTextField {
            let text = passwordTextField.text
            if text != nil && text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != "" {
                fieldValidity[4] = true
            } else {
                fieldValidity[4] = false
                passwordTextField.text = ""
            }
        }
        
    }
    
    @IBAction func signUpButtonTapped(sender: AnyObject) {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        usernameStatusIndicator.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        if !fieldValidity[0] {
            RKDropdownAlert.title("Sign Up Failed", message: "Invalid first name. Please try again.", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
        } else if !fieldValidity[1] {
            RKDropdownAlert.title("Sign Up Failed", message: "Invalid last name. Please try again.", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
        } else if !fieldValidity[2] {
            RKDropdownAlert.title("Sign Up Failed", message: "Invalid username. Please try again.", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
        } else if !fieldValidity[3] {
            RKDropdownAlert.title("Sign Up Failed", message: "Invalid email address. Please try again.", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
        } else if !fieldValidity[4] {
            RKDropdownAlert.title("Sign Up Failed", message: "Invalid password. Please try again.", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
        } else {
            let user = User()
            user.username = usernameTextField.text
            user.password = passwordTextField.text
            user.email = emailTextField.text
            user.firstName = firstNameTextField.text!
            user.lastName = lastNameTextField.text!
            user.signUpInBackgroundWithBlock {
                (signedUp, error) -> Void in
                if error == nil {
                    if let viewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? TabBarController {
                        viewController.initializeTabBar()
                    }
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    RKDropdownAlert.title("Sign Up Failed", message: "Failed to sign up. Please try again later.", backgroundColor: UIColor.redColor(), textColor: UIColor.whiteColor())
                }
            }
        }
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
}

extension String {
    var capitalizeFirst:String {
        var result = self
        result.replaceRange(startIndex...startIndex, with: String(self[startIndex]).capitalizedString)
        return result
    }
    
}