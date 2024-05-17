//
//  MainViewController.swift
//  AnimationQuang
//
//  Created by Irsyad Ashari on 13/05/24.
//

// THIS IS A PROJECT AS AN ANCHOR KNOWLEDGE OF ANIMATION
// SOURCE : https://betterprogramming.pub/getting-start-with-ios-animation-part-1-7bd3a673bee4

import UIKit

class MainViewController: UIViewController {
    
    private let logoSize = CGSize(width: 250, height: 40)
    private var logoImageView: UIImageView!
    
    private let loginButtonSize = CGSize(width: 60, height: 60)
    var loginButton: UIButton!
    
    private let carSize = CGSize(width: 50, height: 45)
    private var carImageView: UIImageView!
    
    private var carAnimator: UIViewPropertyAnimator = UIViewPropertyAnimator(
        duration: 3.0,
        curve: .easeInOut,
        animations: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        animateLogo {
            self.animateLoginButton()
        }
        
    }
    
    @objc private func shakeLogo() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: logoImageView.center.x - 10, y: logoImageView.center.y + 10))
        animation.toValue = NSValue(cgPoint: CGPoint(x: logoImageView.center.x + 10, y: logoImageView.center.y - 10))
        logoImageView.layer.add(animation, forKey: "position")
    }
    
    @objc private func userTapOnCar() {
        if carImageView.frame.origin.x > view.frame.width/2 {
            // Destination is on the right, go back to the left
            self.animateCarToLeft()
        } else {
            // Destination is on the left, go back to the right
            self.animateCarToRight()
        }
    }
    
    private func animateCarToRight() {
        carAnimator.stopAnimation(true)
        carAnimator.addAnimations {
            // Move car to the bottom right of the screen
            self.carImageView.frame = CGRect(
                origin: CGPoint(x: self.view.frame.width - self.carSize.width,
                                y: self.view.frame.height - 100),
                size: self.carSize
            )
        }
        carAnimator.addCompletion { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.carImageView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            }, completion: { _ in
                self.animateCarToLeft()
            })
        }
        carAnimator.startAnimation()
    }
    
    private func animateCarToLeft() {
        carAnimator.stopAnimation(true)
        carAnimator.addAnimations {
            // Move car to the bottom left of the screen
            self.carImageView.frame = CGRect(
                origin: CGPoint(
                x: 0,
                y: self.view.frame.height - 100),
                size: self.carSize
            )
        }
        
        carAnimator.addCompletion { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.carImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { _ in
                self.animateCarToRight()
            })
        }
        
        carAnimator.startAnimation()
    }

    
    private func setupUI() {
        
        // Initialize the logo at the center of screen
        logoImageView = UIImageView(
            frame: CGRect(x: view.frame.width/2 - logoSize.width/2,
                          y: view.frame.height/2 - logoSize.height/2,
                          width: logoSize.width,
                          height: logoSize.height))
        logoImageView.contentMode = .scaleToFill
        logoImageView.image = UIImage(named: "formal")
        view.addSubview(logoImageView)
        
        logoImageView.isUserInteractionEnabled = true
        logoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shakeLogo)))
        
        // Initialize the logo at the center of screen
        loginButton = UIButton(type: .custom)
        loginButton.frame = CGRect(
            x: view.frame.width/2 - loginButtonSize.width/2,
            y: view.frame.height/2 - loginButtonSize.height/2,
            width: loginButtonSize.width,
            height: loginButtonSize.height)
        loginButton.center = view.center
        loginButton.layer.borderColor = UIColor.brown.cgColor
        loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = loginButtonSize.width / 2
        loginButton.setTitle("Open", for: .normal)
        loginButton.setTitleColor(.brown, for: .normal)
        loginButton.setTitleColor(UIColor.brown.withAlphaComponent(0.5),
                                  for: .highlighted)
        loginButton.alpha = 0
        view.addSubview(loginButton)
        
        // Initialize the car at the bottom left of screen
        carImageView = UIImageView(frame: CGRect(
            x: 0,
            y: view.frame.height - 100,
            width: carSize.width,
            height: carSize.height
        ))
        carImageView.contentMode = .scaleToFill
        carImageView.image = UIImage(named: "formal")
        view.addSubview(carImageView)
        
        carImageView.isUserInteractionEnabled = true
        carImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userTapOnCar)))
    }
    
    private func animateLogo(completion: @escaping (()-> ())) {
        UIView.animate(withDuration: 1, animations: {
            self.logoImageView.frame = self.logoImageView.frame.offsetBy(dx: 0, dy: -250)
        }, completion: { _ in
            completion()
        })
    }
    
    private func animateLoginButton() {
        // Step 1: Draw the Bezier path
        let path = UIBezierPath()
        
        // Start at center left of screen
        path.move(to: CGPoint(x: 0, y: view.center.y))
        
        // Add line to the left side -10 px of login button
        path.addLine(to: CGPoint(x: loginButton.center.x - loginButtonSize.width - 10,
                                 y: view.center.y))
        
        // Add arc that go to -10 px bottom of login button
        path.addArc(withCenter: loginButton.center,
                    radius: loginButtonSize.height/2 + 10,
                    startAngle: CGFloat(Double.pi),
                    endAngle: CGFloat(Double.pi/2),
                    clockwise: false)
        
        // Add arc that go to 10 px right of login button
        path.addArc(withCenter: loginButton.center,
                    radius: loginButtonSize.height/2 + 10,
                    startAngle: CGFloat(Double.pi/2),
                    endAngle: CGFloat(0),
                    clockwise: false)
        
        // Add line to the center right of screen
        path.addLine(to: CGPoint(x: view.frame.width,
                                 y: view.center.y))
        
        // Step 2: Create the shape layer from Bezier path
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.brown.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
        
        // Step 3: Setup the animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 2.0
        animation.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeInEaseOut)
        
        // keep to value after finishing
        animation.fillMode = CAMediaTimingFillMode.both
        
        // don't remove after finishing
        animation.isRemovedOnCompletion = false
        
        // Step 4: Perform the animation on the shape layer
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            UIView.animate(withDuration: 0.5, animations: {
                self.loginButton.alpha = 1.0
            })
        })
        shapeLayer.add(animation, forKey: animation.keyPath)
        CATransaction.commit()
    }
}
