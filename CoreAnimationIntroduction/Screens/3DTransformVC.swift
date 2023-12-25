//
//  3DTransformVC.swift
//  CoreAnimationIntroduction
//
//  Created by ndthien01 on 25/12/2023.
//

import Foundation
import UIKit

class ThreeDTransformVC: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "3D Transfrom"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    lazy var transformLabel: UILabel = {
        let transformLabel = UILabel()
        transformLabel.text = "3D Animations"
        transformLabel.translatesAutoresizingMaskIntoConstraints = false
        transformLabel.font = .boldSystemFont(ofSize: 22)
        return transformLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleLabel.layer.transform = create3DMultiTransform()
        createAnimations3DLabel()
    }
}

extension ThreeDTransformVC {
    func setupView() {
        view.backgroundColor = .systemTeal
        view.roundCorner(radius: 12)
        view.addBorder(width: 2, color: .black)
        addTitle()
        addTransitionLabel()
        createFireworkEmitter()
    }
    
    func addTitle() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ])
    }
    
    func addTransitionLabel() {
        view.addSubview(transformLabel)
        
        NSLayoutConstraint.activate([
            transformLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            transformLabel.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
}
// MARK: - 3D Transform
extension ThreeDTransformVC {
    func create3DPerspectiveTransform(cameraDistance: CGFloat) -> CATransform3D {
        var viewPerspective = CATransform3DIdentity
        viewPerspective.m34 = -1/cameraDistance
        return viewPerspective
    }
    
    func create3DMultiTransform() -> CATransform3D {
        var multiTransform = create3DPerspectiveTransform(cameraDistance: 1000)
        
        multiTransform = CATransform3DTranslate(multiTransform, 0, 150, 200)
        multiTransform = CATransform3DRotate(multiTransform, .pi / 2.5, 1, 0, 0)
        multiTransform = CATransform3DScale(multiTransform, 1.7, 1.3, 1)
        
        return multiTransform
    }
}
// MARK: - Animations
extension ThreeDTransformVC {
    func createAnimations3DLabel() {
        var perspectiveTransform = create3DPerspectiveTransform(cameraDistance: 800)
        perspectiveTransform = CATransform3DRotate(perspectiveTransform, .pi, 0, -1, 1)
        
        let rotate3D = CABasicAnimation(keyPath: AnimationHelper.transform)
        rotate3D.duration = 1
        rotate3D.repeatDuration = .infinity
        rotate3D.fromValue = transformLabel.layer.transform
        rotate3D.toValue = perspectiveTransform
        rotate3D.fillMode = .backwards
        
        transformLabel.layer.transform = perspectiveTransform
        
        transformLabel.layer.add(rotate3D, forKey: "rotated_animation")
    }
    
    func createFireworkEmitter() {
        let firework = CAEmitterLayer()
        
        firework.frame = AnimationHelper.screenBounds
        firework.position = .init(x: AnimationHelper.screenBounds.midX,
                                  y: AnimationHelper.screenBounds.midY)
        firework.emitterSize = .init(width: 100, height: 100)
        firework.emitterShape = .point
        firework.emitterCells = [createFirework()]
        
        view.layer.addSublayer(firework)
    }
    
    func createFirework() -> CAEmitterCell {
        let firework = CAEmitterCell()
        
        firework.contents = UIImage(systemName: "flame.fill")?.cgImage
        firework.birthRate = 2
        firework.lifetime = 2
        firework.yAcceleration = 100
        firework.xAcceleration = 10
        firework.velocity = 50
        firework.emissionLongitude = -.pi/4
        firework.scale = 1.5
        firework.color = UIColor.red.cgColor
        
        return firework
    }
}

extension ThreeDTransformVC {
    func positionLabel() {
        let rotAngle = CGFloat.pi/4
        var rotatedTransform = create3DPerspectiveTransform(cameraDistance: 800)
        
        rotatedTransform = CATransform3DRotate(rotatedTransform, rotAngle, 0, 1, 0)
        
        titleLabel.layer.transform = rotatedTransform
    }
}
