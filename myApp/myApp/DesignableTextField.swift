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
            
            let imageView = UIImageView(frame: CGRect(x: 12, y: 0, width: 34, height: 29))
            imageView.image = image
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 58, height: 20))
            view.addSubview(imageView)
            leftView = view
            
        } else{
            //image is nil
            leftViewMode = .never
            
        }
    }

}
