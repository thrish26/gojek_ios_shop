//
//  HomePresenter.swift
//  GoJekUser
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire

class HomePresenter: HomeViewToHomePresenterProtocol {
    
    var homeView: HomePresenterToHomeViewProtocol?
    var homeInteractor: HomePresenterToHomeInteractorProtocol?
    var homeRouter: HomePresenterToHomeRouterProtocol?
    
    func upcomingRequest(param: Parameters){
        homeInteractor?.upcomingRequest(param: param)
    }
    
    func acceptRequest(param: Parameters){
        homeInteractor?.acceptRequest(param: param)
    }
    
    func cancelRequest(param: Parameters){
        homeInteractor?.cancelRequest(param: param)
    }
    func fetchUserProfileDetails() {
        
        homeInteractor?.fetchUserProfileDetails()
    }
}

extension HomePresenter: HomeInteractorToHomePresenterProtocol {
    
    func upcomingRequestSuccess(upcomingRequestEntity: UpcomingRequestEntity) {
        homeView?.upcomingRequestSuccess(upcomingRequestEntity: upcomingRequestEntity)
    }
    
    func cancelRequestSuccess(cancelRequestEntity: UpcomingRequestEntity) {
        homeView?.cancelRequestSuccess(cancelRequestEntity: cancelRequestEntity)
    }
    
    func acceptRequestSuccess(acceptRequestEntity: UpcomingRequestEntity) {
        homeView?.acceptRequestSuccess(acceptRequestEntity: acceptRequestEntity)
    }
    func showUserProfileDtails(details: UserProfileResponse) {
          homeView?.showUserProfileDtails(details: details)
      }
    
}
