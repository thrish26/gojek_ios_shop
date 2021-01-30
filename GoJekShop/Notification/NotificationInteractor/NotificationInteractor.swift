//
//  NotificationInteractor.swift
//  GoJekShop
//
//  Created by anusuya on 18/09/20.
//  Copyright © 2020 appoets. All rights reserved.
//


import UIKit
import Alamofire

class NotificationInteractor: NotificationPresenterToNotificationInteractorProtocol {
    var notificationPresenter: NotificationInteractorToNotificationPresenterProtocol?
    
    func getNotification(param: Parameters, isHideIndicator: Bool) {
        WebServices.shared.requestToApi(type: NotificationEntity.self, with: NotificationAPI.getNotification, urlMethod: .get, showLoader: isHideIndicator, params: param, encode: URLEncoding.default) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.notificationPresenter?.getNotification(notificationEntity: response)
            }
        }
    }
    
    
    
    
}
