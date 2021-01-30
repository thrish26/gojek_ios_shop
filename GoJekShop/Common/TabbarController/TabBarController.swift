//
//  TabBarController.swift
//  TabBarController
//
//  Created by Selva on 18/08/17.
//  Copyright © 2017 optisol. All rights reserved.
//

import UIKit

//@available(iOS 13.0, *)
class TabBarController:  UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.tabBar.tintColor = .appPrimaryColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    
   
    
    func listTabBarController() -> UITabBarController {
        
        // Set up the home View Controller
        let homeViewController = HomeRouter.createHomeModule()
        homeViewController.tabBarItem.title = HomeConstant.THome.localized
        homeViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.setCustomFont(name: .bold, size: .x12)], for: .normal)
        homeViewController.tabBarItem.image = UIImage(named: Constant.home)
        homeViewController.tabBarItem.selectedImage = UIImage(named: Constant.home)
        let homeViewNavigation = UINavigationController(rootViewController: homeViewController)
        
        // Set up the order View Controller
        let ordersController = OrderRouter.createOrdersModule()
        ordersController.tabBarItem.title = OrderConstant.history.localized
        ordersController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.setCustomFont(name: .bold, size: .x12)], for: .normal)
        ordersController.tabBarItem.image = UIImage(named: Constant.order)
        ordersController.tabBarItem.selectedImage = UIImage(named: Constant.order)
        let ordersViewNavigation = UINavigationController(rootViewController: ordersController)

        // Set up the Product View Controller
        let productController = ProductRouter.createProductModule()
        productController.tabBarItem.title = ProductConstant.TProduct.localized
        productController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.setCustomFont(name: .bold, size: .x12)], for: .normal)
        productController.tabBarItem.image = UIImage(named: Constant.ic_product)
        productController.tabBarItem.selectedImage = UIImage(named: Constant.ic_product)
        let productViewNavigation = UINavigationController(rootViewController: productController)
        
        // Set up the notification View Controller
        let notificationController = NotificationRouter.createNotificationModule()
        notificationController.tabBarItem.title = NotificationConstant.TNotification.localized
        notificationController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.setCustomFont(name: .bold, size: .x12)], for: .normal)
        notificationController.tabBarItem.image = UIImage(named: Constant.notification)
        notificationController.tabBarItem.selectedImage = UIImage(named: Constant.notification)
        let notificationViewNavigation = UINavigationController(rootViewController: notificationController)
        


        // Set up the account View Controller
        let myAccountController = AccountRouter.createMyAccountModule()
        myAccountController.tabBarItem.title = AccountConstant.account
        myAccountController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.setCustomFont(name: .bold, size: .x12)], for: .normal)
        myAccountController.tabBarItem.image = UIImage(named: Constant.account)
        myAccountController.tabBarItem.selectedImage = UIImage(named: Constant.account)
        let myAccountViewNavigation = UINavigationController(rootViewController: myAccountController)
        myAccountViewNavigation.navigationItem.hidesBackButton = true

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeViewNavigation,ordersViewNavigation,productViewNavigation,notificationViewNavigation ,myAccountViewNavigation]
        tabBarController.tabBar.tintColor = .appPrimaryColor
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        return tabBarController
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //print("Selected \(viewController.title!)")
    }
}
