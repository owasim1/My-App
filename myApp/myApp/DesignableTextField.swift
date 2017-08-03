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
    
    @IBInspectable var leftPadding : CGFloat = 0{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var upperPadding : CGFloat = 0{
        didSet{
            updateView()
        }
    }
    
    
    func updateView(){
        
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: upperPadding, width: 34, height: 29))
            imageView.image = image
            
            let width = 50 + leftPadding
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            leftView = view
            
        } else{
            //image is nil
            leftViewMode = .never
            
        }
    }

}
