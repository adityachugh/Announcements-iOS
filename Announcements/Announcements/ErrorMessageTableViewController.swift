//
//  ErrorMessageTableViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 11/4/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class ErrorMessageTableViewController: UITableViewController {
    
    var errorLabel: UILabel!
    var showingErrorMessage: Bool {
        get {
            return errorMessageIsShowing
        }
    }
    private var errorMessageIsShowing = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        errorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func showEmptyDataSetMessage(text: String) {
        if !errorMessageIsShowing {
            errorMessageIsShowing = true
            errorLabel.text = text
            errorLabel.textColor = UIColor.grayColor()
            errorLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
            errorLabel.sizeToFit()
            errorLabel.center = self.view.center
            navigationController?.navigationBar.addSubview(errorLabel)
            errorLabel.alpha = 0
            Utilities.animate {
                () -> () in
                self.errorLabel.alpha = 1
            }
        }
    }
    
    func hideEmptyDataSetMessage() {
        if errorMessageIsShowing {
            errorMessageIsShowing = false
            errorLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
            errorLabel.textColor = UIColor.grayColor()
            errorLabel.sizeToFit()
            errorLabel.center = self.view.center
            Utilities.animateWithCompletion({() -> () in
                self.errorLabel.alpha = 0
                }) {() -> () in
                    self.errorLabel.removeFromSuperview()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
    
    // Configure the cell...
    
    return cell
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
