//
//  CommonFuntions.swift
//  GoJekUser
//
//  Created by Ansar on 13/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import UIKit

class CommonFunction: NSObject {
    
    static var isMapKeyExpired:Bool = false
    static var isFirstSignin:Bool = false
    
    static func changeRootController(controller: UIViewController) {
        /* Initiating instance of ui-navigation-controller with view-controller */
        let navigationController = UINavigationController()
        navigationController.viewControllers = [controller]
        navigationController.isNavigationBarHidden = true
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        /* Setting up the root view-controller as ui-navigation-controller */
        appdelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appdelegate.window?.rootViewController = navigationController
        appdelegate.window?.makeKeyAndVisible()
    }
    
    static func forceLogout() {
       
        PersistentManager.shared.delete(entityName: CoreDataEntity.loginData.rawValue)
        PersistentManager.shared.delete(entityName: CoreDataEntity.userData.rawValue)
        BackGroundRequestManager.share.stopBackGroundRequest()
//        BackGroundRequestManager.share.resetBackGroudTask()
//        BackGroundRequestManager.share.stopBackGroundRequest()
//        BackGroundRequestManager.share.
        AppManager.shared.accessToken = ""
        UserDefaults.standard.set(nil, forKey: "AccessToken")
        let topController = UIApplication.topViewController()

        if topController is SignInController {

        
        }else{
            let signIN = LoginRouter.loginStoryboard.instantiateViewController(withIdentifier: LoginConstant.SignInController)
            let navigationController = UINavigationController()
            navigationController.viewControllers = [signIN]
            navigationController.isNavigationBarHidden = true
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            /* Setting up the root view-controller as ui-navigation-controller */
            appdelegate.window = UIWindow(frame: UIScreen.main.bounds)
            appdelegate.window?.rootViewController = navigationController
            appdelegate.window?.makeKeyAndVisible()
        }
    }
    
    static func checkisRTL() -> Bool {
        if let languageStr = UserDefaults.standard.value(forKey: AccountConstant.language) as? String {
            if languageStr == "ar" {
                return true
            }
        }
        return false
    }
}
