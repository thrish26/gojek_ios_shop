//
//  ImageExtension.swift
//  GoJekUser
//
//  Created by Ansar on 21/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    //Tint Color
    func imageTintColor(color1: UIColor) { // -> UIImage
        if self.image == nil {
            return
        }
        UIGraphicsBeginImageContextWithOptions(self.image!.size, false, (self.image?.scale)!)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.image!.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.image!.size.width, height: self.image!.size.height))
        context?.clip(to: rect, mask: self.image!.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = newImage
    }
    
    func setRoundCorner() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height/2
        self.layoutIfNeeded()
    }
}



extension UIImage {

    func convert(toSize size:CGSize, scale:CGFloat) ->UIImage
    {
        let imgRect = CGRect(origin: CGPoint(x:0.0, y:0.0), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: imgRect)
        let copied = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return copied!
    }
    
    
    //MARK: Tint Color
    func imageTintColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? UIImage()
    }
}


