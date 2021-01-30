//
//  AppDelegate.swift
//  GoJekShop
//
//  Created by Sravani on 21/03/19.
//  Copyright © 2019 appoets. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                isDarkMode = true
            }
            else {
                isDarkMode = false
            }
        }
        didFinishLaunchingSetup()
        registerPush(forApp: application)

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
              if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                isDarkMode = true
            }
            else {
                isDarkMode = false
            }
        }
        else{
            isDarkMode = false
        }
       
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
           if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                isDarkMode = true
            }
            else {
                isDarkMode = false
            }
        }
        else{
            isDarkMode = false
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func didFinishLaunchingSetup() {
        
        //  FirebaseApp.configure()
        localizable()
        UNUserNotificationCenter.current().delegate = self
        let splash = LoginRouter.createLoginModule()
        let navigationController = UINavigationController()
        navigationController.viewControllers = [splash]
        /* Setting up the root view-controller as ui-navigation-controller */
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        startNetworkMonitoring()
        IQKeyboardManager.shared.enable = true
    }
    
    func localizable() {
        
        if let languageStr = UserDefaults.standard.value(forKey: AccountConstant.language) as? String, let language = Language(rawValue: languageStr) {
            LocalizeManager.share.setLocalization(language: language)
            
        }else {
            LocalizeManager.share.setLocalization(language: .english)
        }
    }
    
    func startNetworkMonitoring() {
        let reachability = Reachability()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: ReachabilityChangedNotification,
                                               object: reachability)
        do{
            try reachability?.startNotifier()
        } catch {
            print("Could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        switch reachability.currentReachabilityStatus {
        case .notReachable:
            print("Network became unreachable")
            guard let topVC = UIApplication.topViewController() else { return  }
            AppAlert.shared.simpleAlert(view: topVC, title: LoginConstant.validPhone.localized, message: nil)
            
        case .reachableViaWiFi:
            print("Network reachable through WiFi")
            
        case .reachableViaWWAN:
            print("Network reachable through Cellular Data")
            
        }
    }
    
    
}

// MARK:- UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Pass device token to auth
        // Auth.auth().setAPNSToken(deviceToken, type: AuthAPNSTokenType.sandbox)
        // Messaging.messaging().apnsToken = deviceToken
        deviceTokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Apn Token ", deviceToken.map { String(format: "%02.2hhx", $0) }.joined())
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("Error in Notification  \(error.localizedDescription)")
    }
    
    private func registerPush(forApp application : UIApplication){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.alert, .sound]) { (granted, error) in
            
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
    }
}

