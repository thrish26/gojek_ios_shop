//
//  LoginRouter.swift
//  GoJekUser
//
//  Created by apple on 19/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class LoginRouter: LoginPresenterToLoginRouterProtocol {
    
     static func createLoginModule() -> UIViewController {
        let view  = loginStoryboard.instantiateViewController(withIdentifier: LoginConstant.SplashViewController) as! SplashViewController
        let loginPresenter: LoginViewToLoginPresenterProtocol & LoginInterectorToLoginPresenterProtocol = LoginPresenter()
        let logininteractor: LoginPresentorToLoginInterectorProtocol = LoginInteractor()
        let loginRouter: LoginPresenterToLoginRouterProtocol = LoginRouter()

        view.loginPresenter = loginPresenter
        loginPresenter.loginView = view
        loginPresenter.loginRouter = loginRouter
        loginPresenter.loginInterector = logininteractor
        logininteractor.loginPresenter = loginPresenter
        return view
    }
    
    static var loginStoryboard: UIStoryboard {
        return UIStoryboard(name:"Login",bundle: Bundle.main)
    }
}
