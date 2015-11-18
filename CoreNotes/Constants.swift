//
//  Constants.swift
//  CoreNotes
//
//  Created by Anjel Villafranco on 11/18/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit

let green = UIColor(hue:0.27, saturation:0.61, brightness:0.82, alpha:1)
let red = UIColor(hue:0.99, saturation:0.64, brightness:0.93, alpha:1)
let grey = UIColor(hue:0, saturation:0, brightness:0.19, alpha:1)

extension UIColor {
    
    class func green() -> UIColor{
        return UIColor(hue:0.27, saturation:0.61, brightness:0.82, alpha:1)
    }
    class func red() -> UIColor{
        return UIColor(hue:0.99, saturation:0.64, brightness:0.93, alpha:1)
    }
    class func grey() -> UIColor{
        return UIColor(hue:0, saturation:0, brightness:0.19, alpha:1)
    }
}

extension UIViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}