//
//  HomeInteractor.swift
//  GoJekUser
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire

class HomeInteractor: HomePresenterToHomeInteractorProtocol {
    
    var homePresenter: HomeInteractorToHomePresenterProtocol?
    
    func upcomingRequest(param: Parameters) {
        WebServices.shared.requestToApi(type: UpcomingRequestEntity.self, with: HomeAPI.getUpcomingRequest, urlMethod: .get, showLoader: false,params: param, encode: URLEncoding.default) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.homePresenter?.upcomingRequestSuccess(upcomingRequestEntity: response)
            }
        }
    }
    
    func cancelRequest(param: Parameters) {
        WebServices.shared.requestToApi(type: UpcomingRequestEntity.self, with: HomeAPI.cancelRequest, urlMethod: .post, showLoader: true,params: param) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.homePresenter?.cancelRequestSuccess(cancelRequestEntity:response)
            }
        }
    }
    
    func acceptRequest(param: Parameters) {
        WebServices.shared.requestToApi(type: UpcomingRequestEntity.self, with: HomeAPI.acceptRequest, urlMethod: .post, showLoader: true,params: param) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.homePresenter?.acceptRequestSuccess(acceptRequestEntity: response)
            }
        }
    }
    
    //MARK:- Get User Details
       func fetchUserProfileDetails() {
           let url = AccountAPI.editRestaurant + ProductConstant.hash + String(AppManager.shared.storeId ?? 0)

           WebServices.shared.requestToApi(type: UserProfileResponse.self, with: url, urlMethod: .get, showLoader: false, encode: URLEncoding.default) { [weak self] (response) in
               guard let self = self else {
                   return
               }
               if let response = response?.value  {
                   self.homePresenter?.showUserProfileDtails(details: response)
               }
           }
       }

}
