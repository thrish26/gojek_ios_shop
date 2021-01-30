//
//  LoginInteractor.swift
//  GoJekUser
//
//  Created by apple on 19/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire

class LoginInteractor: LoginPresentorToLoginInterectorProtocol{
    
    //MARK:- Presenter
    var loginPresenter: LoginInterectorToLoginPresenterProtocol?
    
    func getBaseURL(param: Parameters) {
       
        
        WebServices.shared.requestToApi(type: BaseEntity.self, with:  APPConstant.baseUrl, urlMethod: .post, showLoader: true,params: param) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.loginPresenter?.getBaseURLResponse(baseEntity: response)
            }
        }
    }
    
    func signin(param: Parameters) {
        WebServices.shared.requestToApi(type: LoginEntity.self, with: LoginAPI.signIn, urlMethod: .post,showLoader: true,params: param) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value  {
                self.loginPresenter?.signinSuccess(loginEntity: response)
            }
        }
    }
    func forgotPassword(param: Parameters) {
          WebServices.shared.requestToApi(type: ForgotPasswordEntity.self, with: LoginAPI.forgotPassword, urlMethod: .post,showLoader: true,params: param) { [weak self] (response) in
              guard let self = self else {
                  return
              }
              if let response = response?.value  {
                  self.loginPresenter?.forgotPasswordSuccess(forgotPasswordEntity: response)
              }
          }
      }
}
