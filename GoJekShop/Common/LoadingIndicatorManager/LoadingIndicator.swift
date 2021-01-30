//
//  LoadingIndicator.swift
//  GoJekUser
//
//  Created by Rajes on 13/04/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Lottie

class LoadingIndicator:NSObject{
    
    static var close: (() -> Void)? = {}
    static var backgroundView:UIView = {
        let sView = UIView()
        sView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        return sView
    }()
    
    static var contentView:AnimationView = {
        let sView = AnimationView(name: "Loader_Color")
        sView.loopMode = .loop
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.backgroundColor = UIColor.clear
        return sView
    }()
    
    static func frameSetup(){
        let window = UIApplication.shared.keyWindow!
        contentView.widthAnchor.constraint(equalTo: window.widthAnchor, multiplier: 0.2).isActive = true
        contentView.heightAnchor.constraint(greaterThanOrEqualTo: window.widthAnchor, multiplier: 0.2).isActive = true
        contentView.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
    }
    
    static func show() {
        DispatchQueue.main.async {
            let window = UIApplication.shared.keyWindow!
            contentView.play()
            backgroundView.frame = window.bounds
            backgroundView.addSubview(contentView)
            window.addSubview(backgroundView)
            frameSetup()
        }
        
    }
    
    static func hide() {
        DispatchQueue.main.async {
            contentView.stop()
            contentView.removeFromSuperview()
            backgroundView.removeFromSuperview()
        }
    }
}

