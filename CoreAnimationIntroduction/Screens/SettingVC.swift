//
//  SettingVC.swift
//  CoreAnimationIntroduction
//
//  Created by ndthien01 on 18/12/2023.
//

import Foundation
import UIKit

class SettingVC: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    private var square: CAShapeLayer!
    private var circle: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addCircle()
        addSquare()
        addLineDashAnimation()
        addCircleMovingAnimation()
        addCirclePathChangeAnimation()
        createReplicatorLayer()
    }
}

// MARK: - Commons Setups
extension SettingVC {
    func setupView() {
        view.backgroundColor = .systemTeal
        view.roundCorner(radius: 12)
        view.addBorder(width: 2, color: .black)
        addTitle()
    }
    
    func addTitle() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ])
    }
}

// MARK: - Shape layer
extension SettingVC {
    func addSquare() {
        square = AnimationHelper.squareShape(at: .init(x: AnimationHelper.screenBounds.midX - 50, y: AnimationHelper.screenBounds.midX + 50))
        view.layer.addSublayer(square)
    }
    
    func addCircle() {
        circle = AnimationHelper.circleShape()
        view.layer.addSublayer(circle)
    }
    
    func createReplicatorLayer() {
        let layer = CAReplicatorLayer()
        layer.frame = .init(x: 0, y: AnimationHelper.screenBounds.height - 300, width: AnimationHelper.screenBounds.width, height: 100)
        layer.masksToBounds = true
        layer.instanceCount = 4
        layer.instanceTransform = CATransform3DMakeTranslation(100, 0, 0)
        
        let pulse = AnimationHelper.fade()
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        layer.add(pulse, forKey: "replicator_animation")
        
        let triangle = AnimationHelper.triangleShape()
        layer.addSublayer(triangle)
        view.layer.addSublayer(layer)
    }
}

// MARK: - Animations
extension SettingVC {
    func addLineDashAnimation() {
        let lineDashAnimation = CABasicAnimation(keyPath: AnimationHelper.dashline)
        lineDashAnimation.fromValue = square.lineDashPattern?.reduce(0, { $0 + $1.intValue })
        lineDashAnimation.toValue = 0
        lineDashAnimation.duration = 0.6
        lineDashAnimation.repeatCount = .infinity
        
        square.add(lineDashAnimation, forKey: "lineDash_animation")
    }
    
    func addCircleMovingAnimation() {
        let animation = CAKeyframeAnimation(keyPath: AnimationHelper.position)
        
        animation.path = square.path
        animation.repeatCount = .infinity
        animation.duration = 5
        
        circle.add(animation, forKey: "circle_animation")
    }
    
    func addCirclePathChangeAnimation() {
        let animation = CABasicAnimation(keyPath: AnimationHelper.keyPath)
        
        animation.duration = 1.5
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.toValue = UIBezierPath(roundedRect: .init(x: -20, y: -20, width: 40, height: 40), cornerRadius: 2).cgPath
        
        circle.add(animation, forKey: "circle_shape_change_animation")
    }
}

