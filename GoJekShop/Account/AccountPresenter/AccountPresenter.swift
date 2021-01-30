//
//  AccountPresenter.swift
//  GoJekUser
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire

//MARK:- AccountViewToAccountPresenterProtocol

class AccountPresenter: AccountViewToAccountPresenterProtocol {
    func getPromoDetails(id: String) {
        accountInterector?.getPromoDetails(id: id)
    }
    
    func addPromo(param: Parameters, imageData: [String : Data]?) {
        accountInterector?.addPromo(param: param, imageData: imageData)
    }
    
    func editPromo(param: Parameters,id: String, imageData: [String : Data]?) {
        accountInterector?.editPromo(param: param, id: id, imageData: imageData)
    }
    
    func getPromoList(id: String, isShowLoader: Bool) {
        accountInterector?.getPromoList(id: id, isShowLoader: isShowLoader)
    }
    
    func deletePromo(promoId: Int) {
        accountInterector?.deletePromo(promoId: promoId)
    }
    
    var accountView: AccountPresenterToAccountViewProtocol?
    var accountInterector: AccountPresenterToAccountInteractorProtocol?
    var acountRouter: AccountPresenterToAccountRouterProtocol?
    
    func changePassword(param: Parameters) {
        accountInterector?.changePassword(param: param)
    }
    func resetPassword(param: Parameters) {
           accountInterector?.resetPassword(param: param)
       }
    
    func toLogout() {
        accountInterector?.toLogout()
    }
    
    func revenueList() {
        accountInterector?.revenueList()
    }
    func getEditTimingList() {
        accountInterector?.getEditTimingList()
    }
    
    func getEditRestaurant() {
        accountInterector?.getEditRestaurant()
    }
    
    func editRestaurant(param: Parameters, imageData: [String : Data]?) {
        accountInterector?.editRestaurant(param: param, imageData: imageData)
    }
    
    func editTiming(param: Parameters) {
        accountInterector?.editTiming(param: param)
    }
}

//MARK:- AccountInteractorToAccountPresenterProtocol

extension AccountPresenter: AccountInteractorToAccountPresenterProtocol {
    func getPromoDetails(editProductEntity: CreatePromoEntity) {
        accountView?.getPromoDetails(editProductEntity: editProductEntity)
    }
    
    func createPromoSuccess(createProductEntity: CreateProductEntity) {
        accountView?.createPromoSuccess(createProductEntity: createProductEntity)
    }
    
    func editPromoSuccess(editProductEntity: CreateProductEntity) {
        accountView?.editPromoSuccess(editProductEntity: editProductEntity)
    }
    
    func getPromoSuccess(getPromoCodeEntity: GetPromoCodeEntity) {
        accountView?.getPromoSuccess(getPromoCodeEntity: getPromoCodeEntity)
    }
    
    func deletePromoSuccess(deletePromoEntity: CreateAddonsEntity) {
        accountView?.deletePromoSuccess(deletePromoEntity: deletePromoEntity)
    }
    
    
    func resetPasswordSuccess(resetPasswordEntity: ResetPasswordEntity) {
        accountView?.resetPassword(resetPasswordEntity: resetPasswordEntity)
    }
    func editTimingSuccess(editTimingEntity: CreateAddonsEntity) {
        accountView?.editTimingSuccess(editTimingEntity: editTimingEntity)
    }
    
    func getEditRestaurantSuccess(editRestaurantEntity: EditRestaurantEntity) {
        accountView?.getEditRestaurantSuccess(editRestaurantEntity: editRestaurantEntity)
    }
    
    func getEditTimingSuccess(editTimingEntity: EditTimingEntity) {
        accountView?.getEditTimingSuccess(editTimingEntity: editTimingEntity)
    }
    
    func changePassword(changePassword: SuccessEntity) {
        accountView?.changePasswordSuccess(changePassword: changePassword)
    }
    
    func getLogoutSuccess(logoutEntity: LogoutEntity) {
        accountView?.getLogoutSuccess(logoutEntity: logoutEntity)
    }
    
    func getRevenueSuccess(revenueEntity: RevenueEntity) {
        accountView?.getRevenueSuccess(revenueEntity: revenueEntity)
    }
    
    func editRestaurantSuccess(editRestaurantEntity: CreateAddonsEntity) {
        accountView?.editRestaurantSuccess(editRestaurantEntity: editRestaurantEntity)
    }
}
