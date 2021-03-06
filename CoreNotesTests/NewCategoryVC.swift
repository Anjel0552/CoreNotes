//
//  NewCategoryVC.swift
//  CoreNotes
//
//  Created by Anjel Villafranco on 11/16/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit
import CoreData 

class NewCategoryVC: UIViewController {

    @IBOutlet weak var categoryNameField: UITextField! {
        
        didSet { categoryNameField.delegate = self }
        
    }
    
    @IBOutlet weak var categoryDatePicker: UIDatePicker!
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func create(sender: AnyObject) {
        
        createCategory()
        dismissViewControllerAnimated(true, completion: nil)
    }
    

}
