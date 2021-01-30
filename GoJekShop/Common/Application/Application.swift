//
//  Application.swift
//  GoJekUser
//
//  Created by Ansar on 25/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    //To the the topview controller of the application
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
}
