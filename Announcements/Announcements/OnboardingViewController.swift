//
//  OnboardingViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 10/4/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.hidden = true
        
        signInButton.layer.borderColor = UIColor.AccentColor().CGColor
        signInButton.layer.borderWidth = 2
        signInButton.layer.cornerRadius = 20
        
        signUpButton.layer.cornerRadius = 20
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
