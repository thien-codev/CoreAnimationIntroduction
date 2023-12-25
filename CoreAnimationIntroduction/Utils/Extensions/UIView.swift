//
//  UIView.swift
//  CoreAnimationIntroduction
//
//  Created by ndthien01 on 14/12/2023.
//

import Foundation
import UIKit

extension UIView {
    func roundCorner(radius: CGFloat = 8) {
        clipsToBounds = true
        layer.cornerRadius = radius
    }
    
    func addBorder(width: CGFloat = 1, color: UIColor) {
        clipsToBounds = true
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
