//
//  LoginPresenter.swift
//  GoJekUser
//
//  Created by apple on 19/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire

class LoginPresenter: LoginViewToLoginPresenterProtocol {
   
    
    var loginView: LoginPresenterToLoginViewProtocol?;
    var loginInterector: LoginPresentorToLoginInterectorProtocol?;
    var loginRouter: LoginPresenterToLoginRouterProtocol?
    
    //getBase url
    func getBaseURL(param: Parameters) {
        loginInterector?.getBaseURL(param: param)
    }
    
    func signin(param: Parameters) {
        loginInterector?.signin(param: param)
    }
    func forgotPassword(param: Parameters) {
           loginInterector?.forgotPassword(param: param)
       }
}

extension LoginPresenter: LoginInterectorToLoginPresenterProtocol {
   
    
    //get base url response
    func getBaseURLResponse(baseEntity: BaseEntity) {
        loginView?.getBaseURLResponse(baseEntity: baseEntity)
    }
    
    func signinSuccess(loginEntity: LoginEntity) {
        loginView?.signinSuccess(loginEntity: loginEntity)
    }
    func forgotPasswordSuccess(forgotPasswordEntity: ForgotPasswordEntity) {
           loginView?.forgotPasswordSuccess(forgotPasswordEntity: forgotPasswordEntity)
       }
    
    //Failure response
    func failureResponse(failureData: Data) {
        loginView?.failureResponse(failureData: failureData)
    }
}
