//
//  LoginProtocol.swift
//  GoJekUser
//
//  Created by apple on 19/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire

var loginPresenterObject: LoginViewToLoginPresenterProtocol?

//MARK:- Login presenter to login viewcontroller
//Backward process
protocol LoginPresenterToLoginViewProtocol: class {
    
    //get base url
    func getBaseURLResponse(baseEntity: BaseEntity)
    func signinSuccess(loginEntity: LoginEntity)
    func forgotPasswordSuccess(forgotPasswordEntity: ForgotPasswordEntity)
    
    //Failure response
    func failureResponse(failureData: Data)
}

extension LoginPresenterToLoginViewProtocol {
    
    var loginPresenter: LoginViewToLoginPresenterProtocol? {
        get {
            loginPresenterObject?.loginView = self
            return loginPresenterObject
        }
        set(newValue) {
            loginPresenterObject = newValue
        }
    }
    
    //get base url
    func getBaseURLResponse(baseEntity: BaseEntity) { return }
    func signinSuccess(loginEntity: LoginEntity) { return }
    func forgotPasswordSuccess(forgotPasswordEntity: ForgotPasswordEntity) { return }


    //Failure response
    func failureResponse(failureData: Data) { return }
}

//MARK:- Login interector to login presenter
//Backward process
protocol LoginInterectorToLoginPresenterProtocol: class {
    
    //get base url
    func getBaseURLResponse(baseEntity: BaseEntity)
    func signinSuccess(loginEntity: LoginEntity)
    func forgotPasswordSuccess(forgotPasswordEntity: ForgotPasswordEntity)

    
    //Failure response
    func failureResponse(failureData: Data)
}

//MARK:- Login presenter to login interector
//Forward process
protocol LoginPresentorToLoginInterectorProtocol: class {
    var loginPresenter: LoginInterectorToLoginPresenterProtocol? {get set}
    
    //Base
    func getBaseURL(param: Parameters)
    func signin(param: Parameters)
     func forgotPassword(param: Parameters)
}

//MARK:- Login view to login presenter
//Forward process
protocol LoginViewToLoginPresenterProtocol: class {
    var loginView: LoginPresenterToLoginViewProtocol? {get set}
    var loginInterector: LoginPresentorToLoginInterectorProtocol? {get set}
    var loginRouter: LoginPresenterToLoginRouterProtocol? {get set}
    
    //Base
    func getBaseURL(param: Parameters)
    func signin(param: Parameters)
    func forgotPassword(param: Parameters)
}

//MARK:- Login presenter to login router
//Forward process
protocol LoginPresenterToLoginRouterProtocol: class {
    
    static func createLoginModule() -> UIViewController
}
