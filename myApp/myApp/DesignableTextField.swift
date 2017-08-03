//
//  DesignableTextField.swift
//  myApp
//
//  Created by Omar Wasim on 8/3/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {

    @IBInspectable var leftImage: UIImage?{
        didSet{
            updateView()
        }
    }
    
    func updateView(){
        
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 20, height: 20))
            imageView.image = image
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
            view.addSubview(imageView)
            leftView = view
            
        } else{
            //image is nil
            leftViewMode = .never
            
        }
    }

}
