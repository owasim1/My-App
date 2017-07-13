//
//  SearchPageController.swift
//  myApp
//
//  Created by Omar Wasim on 7/10/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class SearchPageController: UIViewController {
    
    @IBOutlet weak var budgetTextField: UITextField!
    
    @IBOutlet weak var foodItemTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        budgetTextField.keyboardType = UIKeyboardType.numberPad
    }
    
}
