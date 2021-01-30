//
//  HomeRouter.swift
//  GoJekUser
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit


class HomeRouter: HomePresenterToHomeRouterProtocol {
    
    static func createHomeModule() -> UIViewController {
        let homeViewController  = homeStoryboard.instantiateViewController(withIdentifier: HomeConstant.VHomeViewController) as! HomeController
        let homePresenter: HomeViewToHomePresenterProtocol & HomeInteractorToHomePresenterProtocol = HomePresenter()
        let homeInteractor: HomePresenterToHomeInteractorProtocol = HomeInteractor()
        let homeRouter: HomePresenterToHomeRouterProtocol = HomeRouter()
        
        homeViewController.homePresenter = homePresenter
        homePresenter.homeView = homeViewController
        homePresenter.homeRouter = homeRouter
        homePresenter.homeInteractor = homeInteractor
        homeInteractor.homePresenter = homePresenter
        return homeViewController
    }
    
    static var homeStoryboard: UIStoryboard {
        return UIStoryboard(name:"Home",bundle: Bundle.main)
    }
}




