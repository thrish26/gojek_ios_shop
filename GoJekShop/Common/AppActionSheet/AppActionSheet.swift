//
//  AppActionSheet.swift
//  GoJekUser
//
//  Created by apple on 18/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

@objc protocol AppActionSheetDelegate: class {
    
    //Button One Action
    func actionSheetDelegate(tag: Int) //tag - 0 : button one tag - 1 : button two
    
}

class AppActionSheet: NSObject {
    
    //Singleton class
    static let shared = AppActionSheet()
    
    //Delegate
    weak var delegate: AppActionSheetDelegate?
    
    var onTapAction : ((Int)->Void)?

    //Actionsheet with two button dynamic
    func showActionSheet(viewController: UIViewController,message: String? =  nil, buttonOne: String, buttonTwo: String? = nil, buttonThird: String? = nil) {
        
        let actionSheetController = UIAlertController(title: nil, message:message, preferredStyle: .actionSheet)
        
        //Cancel Button
        let cancelButtonAction = UIAlertAction(title: Constant.SCancel, style: .cancel) { action -> Void in
            
        }
        actionSheetController.addAction(cancelButtonAction)
        
        //Button One
        let buttonOneAction = UIAlertAction(title: buttonOne, style: .default) { action -> Void in
            self.onTapAction?(0)
            self.delegate?.actionSheetDelegate(tag: 0)
        }
        actionSheetController.addAction(buttonOneAction)
        if (buttonTwo != nil) {
            //Button Two
            let buttonTwoAction = UIAlertAction(title: buttonTwo, style: .default) { action -> Void in
                self.onTapAction?(1)
                self.delegate?.actionSheetDelegate(tag: 1)
            }
            actionSheetController.addAction(buttonTwoAction)
        }
        
        if (buttonThird != nil) {
            //Button Two
            let buttonThirdAction = UIAlertAction(title: buttonThird, style: .default) { action -> Void in
                self.onTapAction?(2)
                self.delegate?.actionSheetDelegate(tag: 2)
            }
            actionSheetController.addAction(buttonThirdAction)
        }
        viewController.present(actionSheetController, animated: true, completion: nil)
    }
}
