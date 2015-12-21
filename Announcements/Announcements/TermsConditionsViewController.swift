//
//  TermsConditionsViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 11/16/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class TermsConditionsViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://mindbend.io/informe_terms_conditions.html")!))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func webViewDidStartLoad(webView: UIWebView) {
        title = "Loading..."
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        title = "Terms and Conditions"
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
