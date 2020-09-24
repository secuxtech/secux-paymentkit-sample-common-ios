//
//  IconUITextField.swift
//  shippingassistant
//
//  Created by Maochun Sun on 2019/7/15.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit

@IBDesignable
class IconUITextField: UITextField {
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        if let _ = self.leftImage{
            return bounds.insetBy(dx: 50, dy: 0)
        }else{
            return bounds.insetBy(dx: 5, dy: 0)
        }
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if let _ = self.leftImage{
            return bounds.insetBy(dx: 50, dy: 0)
        }else{
            return bounds.insetBy(dx: 5, dy: 0)
        }
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }

    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            //imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
        
        
        
    }
}
