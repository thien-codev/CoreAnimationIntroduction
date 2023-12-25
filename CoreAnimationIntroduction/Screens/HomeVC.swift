//
//  HomeVC.swift
//  CoreAnimationIntroduction
//
//  Created by ndthien01 on 14/12/2023.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Groups, Keyframes and Transitions"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    lazy var mysteryBox: UIView = {
        let box = UIView()
        box.roundCorner()
        box.addBorder(width: 3, color: .white)
        box.translatesAutoresizingMaskIntoConstraints = false
        return box
    }()
    
    lazy var transitionLabel: UILabel = {
        let transitionLabel = UILabel()
        transitionLabel.text = "Transition Animations"
        transitionLabel.translatesAutoresizingMaskIntoConstraints = false
        transitionLabel.font = .boldSystemFont(ofSize: 22)
        return transitionLabel
    }()
    
    lazy var layerView: UIView = {
        let box = UIView()
        box.roundCorner()
        box.backgroundColor = .white
        box.translatesAutoresizingMaskIntoConstraints = false
        return box
    }()
    
    private let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Groups
        animationGroups()
        // Keyframes
        colorKeyframesAnimation()
        bounceKeyFrameAnimation()
        rotateKeyframeAnimation()
        // Transitions
//        transitionAnimation()
        // Custom layer
        setupGradientLayer()
//        addGradientAnimationColors()
        
        // Transaction
        createTransaction()
    }
}

// MARK: - Custom layer
extension HomeVC {
    func setupGradientLayer() {
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor, UIColor.gray.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = layerView.bounds
        gradientLayer.masksToBounds = true
        gradientLayer.delegate = self
        
        layerView.layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - Animation Groups
extension HomeVC {
    func animationGroups() {
        let animationGroups = CAAnimationGroup()
        animationGroups.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animationGroups.duration = 1
        animationGroups.repeatCount = .infinity
        animationGroups.autoreverses = true
        animationGroups.animations = [scalePulse(), positionPulse()]
        
        titleLabel.layer.add(animationGroups, forKey: "title_groups")
    }
    
    func positionPulse() -> CABasicAnimation {
        
        let positionPulse = CABasicAnimation(keyPath: AnimationHelper.posY)
        positionPulse.fromValue = titleLabel.layer.position.y
        positionPulse.toValue = titleLabel.layer.position.y + 20
        
        return positionPulse
    }
    
    func scalePulse() -> CABasicAnimation {
        
        let scalePulse = CABasicAnimation(keyPath: AnimationHelper.scale)
        scalePulse.fromValue = 1
        scalePulse.toValue = 1.2
        
        return scalePulse
    }
    
    func addGradientAnimationColors() {
        let colors = CABasicAnimation(keyPath: AnimationHelper.gradientColors)
        
        colors.fromValue = [UIColor.black.cgColor, UIColor.white.cgColor, UIColor.gray.cgColor]
        colors.toValue = [UIColor.black.cgColor, UIColor.gray.cgColor, UIColor.white.cgColor]
        colors.duration = 1
        colors.fillMode = .backwards
        colors.autoreverses = true
        
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor, UIColor.gray.cgColor]
        gradientLayer.add(colors, forKey: "gradient_animation")
        
    }
}

// MARK: - Keyframes Animations
extension HomeVC {
    func colorKeyframesAnimation() {
        let keyframeAnimation = CAKeyframeAnimation(keyPath: AnimationHelper.borderColor)
        keyframeAnimation.duration = 1.5
        keyframeAnimation.values = [
            UIColor.white.cgColor,
            UIColor.yellow.cgColor,
            UIColor.red.cgColor
        ]
        keyframeAnimation.keyTimes = [0.0, 0.5, 1.0]
        keyframeAnimation.repeatCount = .infinity
        keyframeAnimation.autoreverses = true
        
        mysteryBox.layer.add(keyframeAnimation, forKey: "mysteryBox_color")
    }
    
    func bounceKeyFrameAnimation() {
        let keyframesAnimation = CAKeyframeAnimation(keyPath: AnimationHelper.position)
        
        keyframesAnimation.duration = 2
        keyframesAnimation.values = [
            CGPoint(x: AnimationHelper.screenBounds.width / 2 + 40, 
                    y: AnimationHelper.screenBounds.height / 2),
            CGPoint(x: AnimationHelper.screenBounds.width / 2 - 40,
                    y: AnimationHelper.screenBounds.height / 2),
            CGPoint(x: AnimationHelper.screenBounds.width / 2 - 40,
                    y: AnimationHelper.screenBounds.height / 2 - 40),
            CGPoint(x: AnimationHelper.screenBounds.width / 2 + 40,
                    y: AnimationHelper.screenBounds.height / 2 - 40),
            CGPoint(x: AnimationHelper.screenBounds.width / 2 + 40,
                    y: AnimationHelper.screenBounds.height / 2)
        ]
        
        keyframesAnimation.repeatCount = .infinity
        
        mysteryBox.layer.add(keyframesAnimation, forKey: "mysteryBox_position")
    }
    
    func rotateKeyframeAnimation() {
        let rotateKeyframe = CAKeyframeAnimation(keyPath: AnimationHelper.rotate)
        
        rotateKeyframe.duration = 1.5
        rotateKeyframe.values = [0, 360]
        rotateKeyframe.repeatCount = .infinity
        
        mysteryBox.layer.add(rotateKeyframe, forKey: "mysteryBox_rotate")
    }
}

// MARK: - Transitions Animation
extension HomeVC {
    func transitionAnimation() {
        let transition = CATransition()
        
        transition.duration = 1.5
        transition.type = .reveal
        transition.subtype = .fromLeft
        transition.autoreverses = true
//        transition.repeatCount = .infinity
        transition.startProgress = 0
        transition.endProgress = 0.8
        
        transitionLabel.layer.add(transition, forKey: "transition")
        transitionLabel.alpha = 0
    }
}

// MARK: - Transaction
extension HomeVC {
    func createTransaction() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(2)
        transitionAnimation()
        
        CATransaction.commit()
    }
}

// MARK: - Common setups
extension HomeVC {
    func setupView() {
        view.backgroundColor = .systemTeal
        view.roundCorner(radius: 12)
        view.addBorder(width: 2, color: .black)
        addTitle()
        addBox()
        addTransitionLabel()
        addLayerView()
    }
    
    func addTitle() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ])
    }
    
    func addBox() {
        view.addSubview(mysteryBox)
        
        NSLayoutConstraint.activate([
            mysteryBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mysteryBox.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mysteryBox.widthAnchor.constraint(equalToConstant: 60),
            mysteryBox.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func addTransitionLabel() {
        view.addSubview(transitionLabel)
        
        NSLayoutConstraint.activate([
            transitionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            transitionLabel.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
    
    func addLayerView() {
        view.addSubview(layerView)
        
        NSLayoutConstraint.activate([
            layerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            layerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            layerView.widthAnchor.constraint(equalToConstant: 100),
            layerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension HomeVC: CALayerDelegate {
    func action(for layer: CALayer, forKey event: String) -> CAAction? {
        switch event {
        case kCAOnOrderIn:
            return GradientAction()
        default:
            return nil
        }
    }
}
