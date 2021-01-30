//
//  Notification.swift
//  GoJekShop
//
//  Created by Anusuya on 18/09/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
 
class NotificationRouter: NotificationPresenterToNotificationRouterProtocol{
    static func createNotificationModule() -> UIViewController {
         let notificationController = notificationStoryboard.instantiateViewController(withIdentifier: NotificationConstant.NotificationViewController) as! NotificationViewController
        
         let notificationPresenter: NotificationViewToNotificationPresenterProtocol & NotificationInteractorToNotificationPresenterProtocol = NotificationPresenter()
        
         let notificationinteractor: NotificationPresenterToNotificationInteractorProtocol = NotificationInteractor()
        
         let notificationRouter: NotificationPresenterToNotificationRouterProtocol = NotificationRouter()
        
         notificationController.notificationPresenter = notificationPresenter
         notificationPresenter.notificationView = notificationController
         notificationPresenter.notificationInteractor = notificationinteractor
         notificationPresenter.notificationRouter = notificationRouter
         notificationinteractor.notificationPresenter = notificationPresenter

         return notificationController
    }
   
    static var notificationStoryboard: UIStoryboard {
        return UIStoryboard(name:"Notification",bundle: Bundle.main)
    }
    
    
}

