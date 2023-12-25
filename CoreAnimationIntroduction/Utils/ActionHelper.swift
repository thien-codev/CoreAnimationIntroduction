//
//  ActionHelper.swift
//  CoreAnimationIntroduction
//
//  Created by ndthien01 on 19/12/2023.
//

import Foundation
import UIKit

class GradientAction: CAAction {
    
    func run(forKey event: String, object anObject: Any, arguments dict: [AnyHashable : Any]?) {
        let layer = anObject as! CAGradientLayer
        let colorChangeAnimation = CABasicAnimation(keyPath: AnimationHelper.gradientColors)
        let finalColors = [UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.blue.cgColor]
        
        colorChangeAnimation.duration = 2
        colorChangeAnimation.fromValue = layer.colors
        colorChangeAnimation.toValue = finalColors
        colorChangeAnimation.fillMode = .backwards
        colorChangeAnimation.beginTime = AnimationHelper.addDelay(time: 4)
        
        layer.colors = finalColors
        layer.add(colorChangeAnimation, forKey: "gradient_colors_change")
    }
}
