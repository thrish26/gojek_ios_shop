//
//  ViewExtension.swift
//  GoJekUser
//
//  Created by Ansar on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import UIKit

enum Transition {
    
    case top
    case bottom
    case right
    case left
    
    var type: String {
        
        switch self {
        case .top :
            return CATransitionSubtype.fromBottom.rawValue
        case .bottom :
            return CATransitionSubtype.fromTop.rawValue
        case .right :
            return CATransitionSubtype.fromLeft.rawValue
        case .left :
            return CATransitionSubtype.fromRight.rawValue
            
        }
    }
}

public let kShapeDashed : String = "kShapeDashed"

extension UIView {
    
    func setRadiusWithShadow(_ radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.7
        self.layer.masksToBounds = false
    }
    
    func removeDashedBorder(_ view: UIView) {
        view.layer.sublayers?.forEach {
            if kShapeDashed == $0.name {
                $0.removeFromSuperlayer()
            }
        }
    }
    
    //Show view with animation
    
    func show(with transition: Transition, duration: CFTimeInterval = 0.5, completion: (()->())?) {
        
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype(rawValue: transition.type)
        animation.duration = duration
        
        self.layer.add(animation, forKey: CATransitionType.push.rawValue)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion?()
        }
    }

    func applyCircleShadow(shadowRadius: CGFloat = 2,
                           shadowOpacity: Float = 0.3,
                           shadowColor: CGColor = UIColor.black.cgColor,
                           shadowOffset: CGSize = CGSize.zero) {
        layer.cornerRadius = frame.size.height / 2
        layer.masksToBounds = false
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }
    
    //Corner Radius
    
    func setCornerRadius() {
        self.clipsToBounds  =  true
        self.layer.cornerRadius = self.frame.height/2
    }

    
    //Set view corner radius with given value
    func setCornerRadiuswithValue(value: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = value
    }
    
    //View Press animation
    
    func addPressAnimation(with duration: TimeInterval = 0.2, transform: CGAffineTransform = CGAffineTransform(scaleX: 0.95, y: 0.95)) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = transform
            
        })
        { (bool) in
            UIView.animate(withDuration: duration, animations: {
                self.transform = .identity
            })
        }
    }
    
    //Top Half Corner in signin & signup
    
    func roundedTop(desiredCurve: CGFloat?){
        let offset:CGFloat =  self.frame.width/(desiredCurve ?? 0.0)
        let bounds: CGRect = self.bounds
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x:bounds.origin.x - offset / 2,y: bounds.origin.y, width : bounds.size.width + offset, height :bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func endEditing() {
        self.endEditing(true)
    }
    
    func addShadow(color: UIColor, radius: CGFloat = 1,fillColor: UIColor) {
        var shadowLayer: CAShapeLayer!
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            shadowLayer.shadowColor = color.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 3
            
            self.layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    func addShadow(radius: CGFloat, color: UIColor) {
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = color.cgColor
    }
    
    func addShadowWithRadius(shadowColor: UIColor, shadowOpacity: Float, shadowRadius: CGFloat, shadowOffset: CGSize) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
    }
    
    //Setting Corner Radius
    @IBInspectable
    var cornerRadius : CGFloat {
        
        get{
            return self.layer.cornerRadius
        }
        
        set(newValue) {
            self.layer.cornerRadius = newValue
        }
        
    }
}

