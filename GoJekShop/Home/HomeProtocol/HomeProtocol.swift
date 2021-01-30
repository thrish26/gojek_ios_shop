//
//  HomeProtocol.swift
//  GoJekUser
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire

var homePresenterObject: HomeViewToHomePresenterProtocol?

// MARK:- HomePresenterToHomeViewProtocol

protocol HomePresenterToHomeViewProtocol: class {
    
    func upcomingRequestSuccess(upcomingRequestEntity: UpcomingRequestEntity)
    func cancelRequestSuccess(cancelRequestEntity: UpcomingRequestEntity)
    func acceptRequestSuccess(acceptRequestEntity: UpcomingRequestEntity)
    func showUserProfileDtails(details:UserProfileResponse)

}

extension HomePresenterToHomeViewProtocol {
    var homePresenter: HomeViewToHomePresenterProtocol? {
        get {
            homePresenterObject?.homeView = self
            return homePresenterObject
        }
        set(newValue) {
            homePresenterObject = newValue
        }
    }
    
    func upcomingRequestSuccess(upcomingRequestEntity: UpcomingRequestEntity) { return }
    func cancelRequestSuccess(cancelRequestEntity: UpcomingRequestEntity){ return }
    func acceptRequestSuccess(acceptRequestEntity: UpcomingRequestEntity){ return }
    func showUserProfileDtails(details:UserProfileResponse){ return }

}

//MARK:- HomeInteractorToHomePresenterProtocol

protocol HomeInteractorToHomePresenterProtocol: class {
    
    func upcomingRequestSuccess(upcomingRequestEntity: UpcomingRequestEntity)
    func cancelRequestSuccess(cancelRequestEntity: UpcomingRequestEntity)
    func acceptRequestSuccess(acceptRequestEntity: UpcomingRequestEntity)
    func showUserProfileDtails(details:UserProfileResponse)

}

//MARK:- HomePresenterToHomeInteractorProtocol

protocol  HomePresenterToHomeInteractorProtocol: class {
    
    var homePresenter: HomeInteractorToHomePresenterProtocol? { get set }
    
    func upcomingRequest(param: Parameters)
    func cancelRequest(param: Parameters)
    func acceptRequest(param: Parameters)
    func fetchUserProfileDetails()

}


//MARK:- HomeViewToHomePresenterProtocol

protocol HomeViewToHomePresenterProtocol: class {
    
    var homeView: HomePresenterToHomeViewProtocol? { get set }
    var homeInteractor: HomePresenterToHomeInteractorProtocol? { get set }
    var homeRouter: HomePresenterToHomeRouterProtocol? { get set }
    
    func upcomingRequest(param: Parameters)
    func cancelRequest(param: Parameters)
    func acceptRequest(param: Parameters)
    func fetchUserProfileDetails()

}

//MARK:- HomePresenterToHomeRouterProtocol

protocol HomePresenterToHomeRouterProtocol {
    static func createHomeModule() -> UIViewController
}
