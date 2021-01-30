//
//  NotificationProtocol.swift
//  GoJekShop
//
//  Created by anusuya on 18/09/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Alamofire

var notificationPresenterObject: NotificationViewToNotificationPresenterProtocol?

// MARK:- Notification Presenter to Notification View Protocol

protocol NotificationPresenterToNotificationViewProtocol: class {
    func getNotification(notificationEntity: NotificationEntity)
    
}

extension NotificationPresenterToNotificationViewProtocol{
    var notificationPresenter: NotificationViewToNotificationPresenterProtocol? {
        get {
            notificationPresenterObject?.notificationView = self
            return notificationPresenterObject
        }
        set(newValue) {
            notificationPresenterObject = newValue
        }
    }
}

//MARK:- Notification Interactor to Notification Presenter Protocol

protocol NotificationInteractorToNotificationPresenterProtocol: class {
 
    func getNotification(notificationEntity: NotificationEntity)
}

//MARK:- Notification Presenter To Notification Interactor Protocol

protocol NotificationPresenterToNotificationInteractorProtocol: class{
    
    var notificationPresenter: NotificationInteractorToNotificationPresenterProtocol? { get set }
    
    func getNotification(param: Parameters,isHideIndicator: Bool)
}

//MARK:- Notification View To Notification Presenter Protocol

protocol NotificationViewToNotificationPresenterProtocol: class {
    
    var notificationView: NotificationPresenterToNotificationViewProtocol? { get set }
    var notificationInteractor: NotificationPresenterToNotificationInteractorProtocol? { get set }
    var notificationRouter: NotificationPresenterToNotificationRouterProtocol? { get set }
    
    
    func getNotification(param: Parameters , isHideIndicator: Bool)
    
    
}
//MARK:- Notification Presenter To Notification Router Protocol

protocol NotificationPresenterToNotificationRouterProtocol {
    
    static func createNotificationModule() -> UIViewController

}

