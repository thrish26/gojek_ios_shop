//
//  AccountRouter.swift
//  GoJekUser
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class AccountRouter: AccountPresenterToAccountRouterProtocol {
    
    static func createMyAccountModule() -> UIViewController {
        
        let myAccountController  = accountStoryboard.instantiateViewController(withIdentifier: AccountConstant.MyAccountController) as! MyAccountController
        let myAccountPresenter: AccountViewToAccountPresenterProtocol & AccountInteractorToAccountPresenterProtocol = AccountPresenter()
        let myAccountinteractor: AccountPresenterToAccountInteractorProtocol = AccountInteractor()
        let myAccountRouter: AccountPresenterToAccountRouterProtocol = AccountRouter()
        
        myAccountController.accountPresenter = myAccountPresenter
        myAccountPresenter.accountView = myAccountController
        myAccountPresenter.acountRouter = myAccountRouter
        myAccountPresenter.accountInterector = myAccountinteractor
        myAccountinteractor.accountPresenter = myAccountPresenter
        return myAccountController
    }
    
    static func createModule(controller: (UIViewController & AccountPresenterToAccountViewProtocol)) -> (AccountViewToAccountPresenterProtocol & AccountInteractorToAccountPresenterProtocol) {
        let presenter:AccountViewToAccountPresenterProtocol & AccountInteractorToAccountPresenterProtocol = AccountPresenter()
        let interactor: AccountPresenterToAccountInteractorProtocol = AccountInteractor()
        let router: AccountPresenterToAccountRouterProtocol = AccountRouter()
        presenter.accountView = controller
        presenter.accountInterector = interactor
        presenter.acountRouter = router
        interactor.accountPresenter = presenter
        return presenter
        
    }
    static func createChangePasswordModule(isFromforgotPwd: Bool,otpString: String,accountType: accountType,emailOrPhone: String,countryCode: String) -> UIViewController {
        let changePasswordController  = accountStoryboard.instantiateViewController(withIdentifier: AccountConstant.ChangePasswordController) as! ChangePasswordController
        let presenter:AccountViewToAccountPresenterProtocol & AccountInteractorToAccountPresenterProtocol = AccountPresenter()
        let interactor: AccountPresenterToAccountInteractorProtocol = AccountInteractor()
        let router: AccountPresenterToAccountRouterProtocol = AccountRouter()
        changePasswordController.accountPresenter = presenter
        presenter.accountView = changePasswordController
        presenter.accountInterector = interactor
        presenter.acountRouter = router
        interactor.accountPresenter = presenter
        changePasswordController.isFromForgotPassword = isFromforgotPwd
        changePasswordController.otpString = otpString
        changePasswordController.accountType = accountType
        changePasswordController.emailOrPhone = emailOrPhone
        changePasswordController.countryCode = countryCode
        return changePasswordController
        
    }
    
    static var accountStoryboard: UIStoryboard {
        return UIStoryboard(name:"Account",bundle: Bundle.main)
    }
    
}
