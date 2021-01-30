//
//  TextFieldExtension.swift
//  GoJekUser
//
//  Created by Ansar on 28/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setRightView(imageStr:String,tintColor:UIColor)  {
        
        let rightView = UIView()
        let rightImageView =  UIImageView()
        let viewHeight = self.frame.height
        let image = UIImage(named: imageStr)
        // set frame on image before adding it to the uitextfield
        rightView.frame = CGRect(x: (self.frame.size.width/2) - (viewHeight/2) , y: (self.frame.size.height/2) - (viewHeight/2), width: self.frame.height-5, height: self.frame.height-5)
        rightView.cornerRadius = 5.0
        rightImageView.image = image
        rightImageView.imageTintColor(color1: tintColor)
        rightView.backgroundColor = tintColor.withAlphaComponent(0.3)
        rightImageView.frame = CGRect(x: (rightView.frame.width/2)-10 , y: (rightView.frame.width/2)-10, width: 20, height: 20)
        rightView.addSubview(rightImageView)
        self.rightView = rightView
        self.rightViewMode = .always
    }
    
    func setLeftView(imageStr:String)  {
        
        let leftViewContainer = UIView()
        let leftImageView =  UIImageView()
        let image = UIImage(named: imageStr)
        leftImageView.image = image
       // let imageHeight = self.frame.height/3
        self.leftViewMode = .always
        leftImageView.frame = CGRect(x: 0 , y: 0, width: self.frame.height, height: self.frame.height)
        leftViewContainer.frame = leftImageView.frame
        leftImageView.frame.size.width =  leftImageView.frame.size.width / 2.5
        leftImageView.frame.size.height =  leftImageView.frame.size.width
        leftImageView.center  = leftViewContainer.center
        leftViewContainer.addSubview(leftImageView)
        self.leftView = leftViewContainer//leftImageView
        
        
    }
    
    func setFlag(imageStr:String)  {
        
        let leftViewContainer = UIView()
        let leftImageView =  UIImageView()
        let image = UIImage(named: imageStr)
        leftImageView.image = image
        // let imageHeight = self.frame.height/3
        self.leftViewMode = .always
        leftImageView.frame = CGRect(x: 0 , y: 0, width: self.frame.height, height: self.frame.height)
        leftViewContainer.frame = leftImageView.frame
        let height = (leftImageView.frame.size.height/100)*40
        leftImageView.frame.size.width =  height * 1.5//leftImageView.frame.size.width / 2.5
        leftImageView.frame.size.height =  height
        leftImageView.contentMode = .scaleAspectFit
        leftImageView.center  = leftViewContainer.center
        leftViewContainer.addSubview(leftImageView)
        self.leftView = leftViewContainer//leftImageView
        
        
    }
}

