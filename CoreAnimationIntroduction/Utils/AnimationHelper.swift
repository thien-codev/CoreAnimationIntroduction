//
//  AnimationHelper.swift
//  CoreAnimationIntroduction
//
//  Created by ndthien01 on 12/12/2023.
//

import Foundation
import UIKit

class AnimationHelper {
    
    // MARK: - Animatable Properties
    static let opacity = "opacity"
    static let posY = "position.y"
    static let borderColor = "borderColor"
    static let scale = "transform.scale"
    static let position = "position"
    static let rotate = "transform.rotation"
    static let gradientColors = "colors"
    static let dashline = "lineDashPhase"
    static let keyPath = "path"
    static let gradientLocations = "locations"
    static let transform = "transform"
    
    // MARK: - Utilities
    static var screenBounds: CGRect {
        UIScreen.main.bounds
    }
    
    static func addDelay(time: CFTimeInterval) -> CFTimeInterval {
        CACurrentMediaTime() + time
    }
    
    // MARK: - Common Animations
    static func fade() -> CABasicAnimation {
        let fadeIn = CABasicAnimation(keyPath: opacity)
        
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0
        fadeIn.duration = 1.0
        fadeIn.fillMode = CAMediaTimingFillMode.backwards
        
        return fadeIn
    }
    
    static func movingSping(fromValue: Any?, toValue: Any?) -> CASpringAnimation {
        let moveUp = CASpringAnimation(keyPath: posY)
        
        moveUp.fromValue = fromValue
        moveUp.toValue = toValue
        moveUp.duration = moveUp.settlingDuration
        moveUp.fillMode = CAMediaTimingFillMode.backwards
        
        // spring physic properties
        moveUp.initialVelocity = 10
        moveUp.mass = 0.5
        moveUp.stiffness = 20
        moveUp.damping = 12
        
        return moveUp
    }
    
    static func borderColorAnimation(toValue: Any?) -> CABasicAnimation {
        let colorAnimation = CABasicAnimation(keyPath: borderColor)
        colorAnimation.fromValue = UIColor.clear.cgColor
        colorAnimation.toValue = toValue
        colorAnimation.duration = 1.0
        colorAnimation.repeatCount = .infinity
        colorAnimation.autoreverses = true
        colorAnimation.speed = 4
        
        return colorAnimation
    }
    
    static func poppingAnimation(to: Any?) -> CABasicAnimation {
        let scaleAnimation = CASpringAnimation(keyPath: scale)
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = to
        scaleAnimation.duration = 0.2
        scaleAnimation.autoreverses = true
        
        return scaleAnimation
    }
    
    // MARK: - Shapes
    static func squareShape(at point: CGPoint = .zero) -> CAShapeLayer {
        let square = CAShapeLayer()
        let frame = CGRect(origin: point, size: CGSize(width: 100, height: 100))
        let path = UIBezierPath(rect: frame)
        
        square.path = path.cgPath
        square.lineWidth = 4.0
        square.fillColor = UIColor.clear.cgColor
        square.strokeColor = UIColor.white.cgColor
        square.lineDashPattern = [20, 5]
        
        return square
    }
    
    static func circleShape() -> CAShapeLayer {
        let square = CAShapeLayer()
        let frame = CGRect(origin: .init(x: -20, y: -20), size: CGSize(width: 40, height: 40))
        let path = UIBezierPath(roundedRect: frame, cornerRadius: 20)
        
        square.path = path.cgPath
        square.fillColor = UIColor.yellow.cgColor
        
        return square
    }
    
    static func triangleShape() -> CAShapeLayer {
        let triangle = CAShapeLayer()
        let path = CGMutablePath()
        
        path.move(to: .zero)
        path.addLine(to: .init(x: 100, y: 100))
        path.addLine(to: .init(x: 200, y: 50))
        path.addLine(to: .zero)
        triangle.path = path
        triangle.fillColor = UIColor.green.cgColor
        
        return triangle
    }
}
