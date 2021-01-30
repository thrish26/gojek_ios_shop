//
//  ToastView.swift
//  GoJekUser
//
//  Created by Rajes on 30/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//


import Foundation
import UIKit

class ToastView: UIView {
    
    var contentView: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        return sView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    var imageView: UIImageView = {
        let imageIconView = UIImageView()
        imageIconView.translatesAutoresizingMaskIntoConstraints = false
        imageIconView.contentMode = .scaleAspectFit
        return imageIconView
    }()
    
    var imageViewContainer: UIView = {
        let imageIconView = UIView()
        imageIconView.translatesAutoresizingMaskIntoConstraints = false
        return imageIconView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
        setFrame()
    }
    
    func commonInit() {
        
        self.addSubview(contentView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(imageViewContainer)
        self.imageViewContainer.addSubview(imageView)
    }
    
    func setFrame(){
        
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageViewContainer.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2).isActive = true
        imageViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalTo: imageViewContainer.heightAnchor, multiplier: 0.48).isActive =  true
        imageView.heightAnchor.constraint(equalTo: imageViewContainer.heightAnchor, multiplier: 0.48).isActive =  true
        imageView.centerYAnchor.constraint(equalTo: imageViewContainer.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: imageViewContainer.centerXAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
}

enum ToastType {
    case error
    case success
    case warning
}

class ToastManager {
    
    static func show(title: String, state: ToastType) {
        
        if title.trimString().count == 0 {return}
        var width: CGFloat = 140
        // width = CGFloat(Float(title.count) * 8.5)
        
        let size: CGSize = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]) //Calculate as per label font
        
        width = size.width + 12
        if width < 80 {
            width = 80
        } else if width > 200 {
            width -= size.width * 0.1
        }
        
        if title.count > 15 && title.count < 20 {
            let w = width
            width = w - 12
        }
        
        if title.count > 15 && title.count > 20 {
            let w = width
            width = w - 8
        }
        
        print("toast frame \(size) \(width)")
        
        width = width + 20
        let window = UIApplication.shared.keyWindow!
        width = window.frame.size.width * 0.8
        
        let toastHeight = window.frame.size.width * 0.1
        let xpos = (window.frame.size.width/2) - (width/2)
        let toastView = ToastView(frame: (CGRect.init(x: xpos, y: 0, width: width, height: toastHeight)))
        toastView.tag = 1111
        
        toastView.frame.origin.x = (window.frame.size.width / 2) - ((toastView.frame.size.width ) / 2)
        
        for sViuew in window.subviews {
            if sViuew.tag == 1111 {
                sViuew.removeFromSuperview()
            }
        }
        switch state {
        case .success:
            toastView.contentView.backgroundColor = UIColor(red: 0, green: 128/255, blue: 0, alpha: 1)//UIColor.green
            toastView.imageView.image = #imageLiteral(resourceName: "SuccessIcon")
        case .error:
            toastView.contentView.backgroundColor = UIColor.red
            toastView.imageView.image = #imageLiteral(resourceName: "ErrorIcon")
        case .warning:
            toastView.contentView.backgroundColor =  UIColor(red: 237/255, green: 180/255, blue: 67/255, alpha: 1)
            toastView.imageView.image = #imageLiteral(resourceName: "ErrorIcon")
        }
        DispatchQueue.main.async {
            window.addSubview(toastView)
            window.layer.zPosition = 1;
                        
            toastView.titleLabel.text = title
            toastView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
                let window = UIApplication.shared.keyWindow
                let topPadding = window?.safeAreaInsets.top
                let topVal = (topPadding  ?? 0) + 44 + 8
                toastView.frame.origin.y = topVal
                toastView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                
            }, completion: { (_) in
                toastView.layoutIfNeeded()
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                
                toastView.frame.origin.y = -100
                toastView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                
            }) { (_) in
                
                toastView.removeFromSuperview()
                
            }
        }
        
    }
}
