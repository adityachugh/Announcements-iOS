//
//  TextInputTableViewCell.swift
//  infor[me]
//
//  Created by Aditya Chugh on 10/14/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit

class TextInputTableViewCell: UITableViewCell, UITextFieldDelegate {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var remainingCharacterCountLabel: UILabel!
    
    var currentCharacterCount = 0 {
        didSet {
            if let maxCharacters = maxCharacterCount {
                if currentCharacterCount > maxCharacters {
                    remainingCharacterCountLabel.text = "0"
                } else {
                    remainingCharacterCountLabel.text = "\(maxCharacters-currentCharacterCount)"
                }
            }
        }
    }
    var maxCharacterCount: Int? {
        didSet {
            if let characterCount = maxCharacterCount {
                remainingCharacterCountLabel.text = "\(characterCount)"
            } else {
                remainingCharacterCountLabel.text = ""
            }
        }
    }
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    var input: String? {
        get {
            return inputTextField.text
        }
        set {
            inputTextField.text = newValue
        }
    }
    var placeholder: String? {
        get {
            return inputTextField.placeholder
        }
        set {
            inputTextField.placeholder = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if maxCharacterCount == nil {
            remainingCharacterCountLabel.text = ""
        }
        inputTextField.text = ""
        inputTextField.delegate = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
        inputTextField.becomeFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        currentCharacterCount = textField.text!.characters.count + string.characters.count - range.length
        if maxCharacterCount != nil {
            if (range.length + range.location > textField.text!.characters.count)
            {
                return false;
            }
            return currentCharacterCount <= maxCharacterCount
        } else {
            return true
        }
    }
}
