//
//  ViewController.swift
//  CoreAnimationIntroduction
//
//  Created by ndthien01 on 12/12/2023.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Core Animation Introduction"
        title.font = .boldSystemFont(ofSize: 26)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        button.setTitle("Home", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.setTitleColor(.black, for: .normal)
        button.roundCorner()
        button.addBorder(width: 2, color: .white)
        return button
    }()
    
    lazy var settingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(settingOnTap), for: .touchUpInside)
        button.setTitle("Setting", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.setTitleColor(.black, for: .normal)
        button.roundCorner()
        button.addBorder(width: 2, color: .white)
        return button
    }()
    
    lazy var threeDButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(threeDTranformOnTap), for: .touchUpInside)
        button.setTitle("3D", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.setTitleColor(.black, for: .normal)
        button.roundCorner()
        button.addBorder(width: 2, color: .white)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        movingSpring()
    }
}

// MARK: - Common setups
extension ViewController {
    func setupView() {
        view.backgroundColor = .systemTeal
        addButton()
        addTitle()
        addSettingButton()
        add3DButton()
    }
    
    func addButton() {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func addTitle() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -140)
        ])
    }
    
    func addSettingButton() {
        view.addSubview(settingButton)
        
        NSLayoutConstraint.activate([
            settingButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            settingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingButton.heightAnchor.constraint(equalToConstant: 50),
            settingButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func add3DButton() {
        view.addSubview(threeDButton)
        
        NSLayoutConstraint.activate([
            threeDButton.topAnchor.constraint(equalTo: settingButton.bottomAnchor, constant: 20),
            threeDButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            threeDButton.heightAnchor.constraint(equalToConstant: 50),
            threeDButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func openGroupsKeyframesTransitions() {
        let vc = HomeVC()
        present(vc, animated: true)
    }
    
    func openSetting() {
        let vc = SettingVC()
        present(vc, animated: true)
    }
    
    func open3DTransform() {
        let vc = ThreeDTransformVC()
        present(vc, animated: true)
    }
    
    @objc func onTap() {
        print("=== onTap")
        poppingAnimation()
        openGroupsKeyframesTransitions()
    }
    
    @objc func settingOnTap() {
        openSetting()
    }
    
    @objc func threeDTranformOnTap() {
        open3DTransform()
    }
}

// MARK: - Animations
extension ViewController {
    func fadeInView() {
        let fade = AnimationHelper.fade()
        fade.delegate = self
        fade.beginTime = AnimationHelper.addDelay(time: 1)
        fade.setValue("fading", forKey: "animation")
        button.layer.add(fade, forKey: nil)
    }
    
    func movingSpring() {
        let moveUp = AnimationHelper.movingSping(fromValue: AnimationHelper.screenBounds.height + button.layer.position.y,
                                                 toValue: button.layer.position.y)
        moveUp.delegate = self
        moveUp.setValue("moving", forKey: "animation")
        button.layer.add(moveUp, forKey: nil)
    }
    
    func animationBorderColorPulse() {
        let colorAnimation = AnimationHelper.borderColorAnimation(toValue: UIColor.white.cgColor)
        
        button.layer.add(colorAnimation, forKey: nil)
    }
    
    func poppingAnimation() {
        let poppingAnimation = AnimationHelper.poppingAnimation(to: 1.3)
        
        button.layer.add(poppingAnimation, forKey: nil)
    }
}

// MARK: - CAAnimationDelegate
extension ViewController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        //
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let animName = anim.value(forKey: "animation") as? String else { return }
        
        switch animName {
        case "fading":
            movingSpring()
        case "moving":
            print("=== done moving")
            animationBorderColorPulse()
        default:
            break
        }
    }
}

