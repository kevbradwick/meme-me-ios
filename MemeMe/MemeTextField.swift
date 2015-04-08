//
//  MemeTextField.swift
//  MemeMe
//
//  Created by Kevin Bradwick on 05/04/2015.
//  Copyright (c) 2015 KodeFoundry. All rights reserved.
//

import UIKit

class MemeTextField: UITextField, UITextFieldDelegate {
    
    var defaultText = ""
    
    // default text attributes for top and bottom text fields
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSStrokeWidthAttributeName: -2,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    ]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.defaultTextAttributes = memeTextAttributes
        self.backgroundColor = UIColor.clearColor()
        self.borderStyle = .None
        self.textAlignment = NSTextAlignment.Center
        self.delegate = self
    }

    /*!
        When the enter button is hit, then the text field should resign first responder.
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*!
        Simulated placeholder behaviour. Simply clears input if the text present is the default text.
    */
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField.text == defaultText {
            textField.text = ""
        }
    }
}
