//
//  AccountProtocol.swift
//  GoJekUser
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire

var accountPresenterObject: AccountViewToAccountPresenterProtocol?

//MARK:- AccountPresenterToAccountViewProtocol

protocol AccountPresenterToAccountViewProtocol: class {
    
    func changePasswordSuccess(changePassword: SuccessEntity)
    func getLogoutSuccess(logoutEntity: LogoutEntity)
    func getRevenueSuccess(revenueEntity: RevenueEntity)
    func getEditTimingSuccess(editTimingEntity: EditTimingEntity)
    func getEditRestaurantSuccess(editRestaurantEntity: EditRestaurantEntity)
    func editRestaurantSuccess(editRestaurantEntity: CreateAddonsEntity)
    func editTimingSuccess(editTimingEntity: CreateAddonsEntity)
    func resetPassword(resetPasswordEntity: ResetPasswordEntity)
    func showFailureDetails()
    func getPromoSuccess(getPromoCodeEntity: GetPromoCodeEntity)
    func deletePromoSuccess(deletePromoEntity: CreateAddonsEntity)
    func createPromoSuccess(createProductEntity: CreateProductEntity)
    func editPromoSuccess(editProductEntity: CreateProductEntity)
    func getPromoDetails(editProductEntity: CreatePromoEntity)
}

extension AccountPresenterToAccountViewProtocol {
    
    var accountPresenter: AccountViewToAccountPresenterProtocol? {
        get {
            accountPresenterObject?.accountView = self
            return accountPresenterObject
        }
        set(newValue) {
            accountPresenterObject = newValue
        }
    }
    
    func changePasswordSuccess(changePassword:  SuccessEntity) { return }
    func getLogoutSuccess(logoutEntity: LogoutEntity) { return }
    func getRevenueSuccess(revenueEntity: RevenueEntity) { return }
    func getEditTimingSuccess(editTimingEntity: EditTimingEntity) { return }
    func getEditRestaurantSuccess(editRestaurantEntity: EditRestaurantEntity) { return }
    func editRestaurantSuccess(editRestaurantEntity: CreateAddonsEntity) { return }
    func editTimingSuccess(editTimingEntity: CreateAddonsEntity) { return }
    func resetPassword(resetPasswordEntity: ResetPasswordEntity) { return }
    func showFailureDetails() { return }
    func getPromoSuccess(getPromoCodeEntity: GetPromoCodeEntity) { return }
    func deletePromoSuccess(deletePromoEntity: CreateAddonsEntity) { return }
    func createPromoSuccess(createProductEntity: CreateProductEntity) { return }
    func editPromoSuccess(editProductEntity: CreateProductEntity) { return }
    func getPromoDetails(editProductEntity: CreatePromoEntity) { return }

}

//MARK:- AccountInteractorToAccountPresenterProtocol

protocol AccountInteractorToAccountPresenterProtocol: class {
        
    func changePassword(changePassword: SuccessEntity)
    func getLogoutSuccess(logoutEntity: LogoutEntity)
    func getRevenueSuccess(revenueEntity: RevenueEntity)
    func getEditTimingSuccess(editTimingEntity: EditTimingEntity)
    func getEditRestaurantSuccess(editRestaurantEntity: EditRestaurantEntity)
    func editRestaurantSuccess(editRestaurantEntity: CreateAddonsEntity)
    func editTimingSuccess(editTimingEntity: CreateAddonsEntity)
    func resetPasswordSuccess(resetPasswordEntity: ResetPasswordEntity)
    func getPromoSuccess(getPromoCodeEntity: GetPromoCodeEntity)
    func deletePromoSuccess(deletePromoEntity: CreateAddonsEntity)
    func createPromoSuccess(createProductEntity: CreateProductEntity)
    func editPromoSuccess(editProductEntity: CreateProductEntity)
    func getPromoDetails(editProductEntity: CreatePromoEntity)

}

//MARK:- AccountPresenterToAccountInteractorProtocol

protocol AccountPresenterToAccountInteractorProtocol: class {
    
    var accountPresenter: AccountInteractorToAccountPresenterProtocol? {get set}
    
    func changePassword(param: Parameters)
    func toLogout()
    func revenueList()
    func getEditTimingList()
    func getEditRestaurant()
    func editRestaurant(param: Parameters, imageData: [String : Data]?)
    func editTiming(param: Parameters)
    func resetPassword(param: Parameters)
    func getPromoList(id: String,isShowLoader: Bool)
    func deletePromo(promoId: Int)
    func addPromo(param: Parameters, imageData: [String : Data]?)
    func editPromo(param: Parameters,id: String, imageData: [String : Data]?)
    func getPromoDetails(id: String)

}

//MARK:- AccountViewToAccountPresenterProtocol

protocol AccountViewToAccountPresenterProtocol: class {
    
    var accountView: AccountPresenterToAccountViewProtocol? {get set}
    var accountInterector: AccountPresenterToAccountInteractorProtocol? {get set}
    var acountRouter: AccountPresenterToAccountRouterProtocol? {get set}
    func resetPassword(param: Parameters)
    func changePassword(param: Parameters)
    func toLogout()
    func revenueList()
    func getEditTimingList()
    func getEditRestaurant()
    func editRestaurant(param: Parameters, imageData: [String : Data]?)
    func editTiming(param: Parameters)
    func getPromoList(id: String,isShowLoader: Bool)
    func deletePromo(promoId: Int)
    func addPromo(param: Parameters, imageData: [String : Data]?)
    func editPromo(param: Parameters,id: String, imageData: [String : Data]?)
    func getPromoDetails(id: String)
}

//MARK:- AccountPresenterToAccountRouterProtocol

protocol AccountPresenterToAccountRouterProtocol: class {
    
    // static func createModule(viewIdentifier: String, currentController: UIViewController) -> UIViewController
}

protocol PaymentBackDelegate {
    func isFromCard()
}
