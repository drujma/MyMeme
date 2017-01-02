//
//  TextFieldDelegate.swift
//  Meme
//
//  Created by Fabrizio De Stefani on 26/12/2016.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit

class TextFieldDelegate : NSObject, UITextFieldDelegate {
    
    var defaultText : String!
    
    init(_ defaultText : String) {
        self.defaultText = defaultText
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if(textField.text?.lowercased() == self.defaultText){
            textField.text = ""
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
