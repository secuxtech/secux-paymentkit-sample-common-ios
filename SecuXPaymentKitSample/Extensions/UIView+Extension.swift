//
//  UIView+Extension.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/13.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit

extension UIView {
   
    
    func shake(count : Float = 4,for duration : TimeInterval = 0.3,withTranslation translation : Float = 3) {

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}
