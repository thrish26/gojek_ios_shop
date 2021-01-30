//
//  NotificationPresenter.swift
//  GoJekShop
//
//  Created by anusuya on 18/09/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Alamofire

class NotificationPresenter: NotificationViewToNotificationPresenterProtocol {
    
    var notificationView: NotificationPresenterToNotificationViewProtocol?
    
    var notificationInteractor: NotificationPresenterToNotificationInteractorProtocol?
    
    var notificationRouter: NotificationPresenterToNotificationRouterProtocol?
    
    func getNotification(param: Parameters, isHideIndicator: Bool) {
        notificationInteractor?.getNotification(param: param, isHideIndicator: isHideIndicator)
    }
    
}

extension NotificationPresenter: NotificationInteractorToNotificationPresenterProtocol {
   
    func getNotification(notificationEntity: NotificationEntity) {
        notificationView?.getNotification(notificationEntity: notificationEntity)
    }
    
    
}
