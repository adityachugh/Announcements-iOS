//
//  TextViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 9/3/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, UITextViewDelegate {
    
    var maxCharacterCount: Int?
    var currentCharacterCount = 0 {
        didSet {
            characterCountLabel.text = "\(maxCharacterCount!-currentCharacterCount)"
        }
    }
    var shouldShowActivityIndicator = false {
        didSet {
            Utilities.animate {
                () -> () in
                self.activityIndicator.alpha = self.shouldShowActivityIndicator ? 1 : 0
            }
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    var delegate: TextViewControllerDelegate?
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.clearColor()
        textView.delegate = self
        shouldShowActivityIndicator = false
        if maxCharacterCount == nil {
            characterCountLabel.text = ""
        } else {
            characterCountLabel.text = "\(maxCharacterCount!-currentCharacterCount)"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        hide()
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        Utilities.animate {
            () -> () in
            self.show()
        }
    }
    
    func hide() {
        backgroundView.alpha = 0
        contentView.frame = CGRectOffset(contentView.frame, 0, -view.bounds.size.height)
    }
    
    func show() {
        self.backgroundView.alpha = 1
        self.contentView.center = self.view.center
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        delegate?.didCancelTextEntry(self)
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        delegate?.didEnterText(self, text: textView.text)
        println((delegate as! CommentsTableViewController).post)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        currentCharacterCount = count(textView.text) + count(text) - range.length
        if maxCharacterCount != nil {
            if (range.length + range.location > count(textView.text) )
            {
                return false;
            }
            return currentCharacterCount < maxCharacterCount
        } else {
            return true
        }
    }
}

protocol TextViewControllerDelegate {
    func didCancelTextEntry(viewController: TextViewController)
    func didEnterText(viewController: TextViewController, text: String)
}