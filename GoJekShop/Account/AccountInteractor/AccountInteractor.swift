//
//  AccountInteractor.swift
//  GoJekUser
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire

class AccountInteractor: AccountPresenterToAccountInteractorProtocol {
    func getPromoDetails(id: String) {
        let productList =  AccountAPI.promocode + "/" + id
        WebServices.shared.requestToApi(type: CreatePromoEntity.self, with: productList, urlMethod: .get, showLoader: true,params: nil, encode: URLEncoding.default) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.accountPresenter?.getPromoDetails(editProductEntity: response)
            }
        }
    }
    
    func addPromo(param: Parameters, imageData: [String : Data]?) {
        let addProduct =  ProductAPI.promo
         
         WebServices.shared.requestToImageUpload(type: CreateProductEntity.self, with: addProduct, imageData: imageData, showLoader: true, params: param) { [weak self] (response) in
             guard let self = self else {
                 return
             }
             if let response = response?.value {
                 self.accountPresenter?.createPromoSuccess(createProductEntity: response)
             }
         }
    }
    
    func editPromo(param: Parameters,id: String, imageData: [String : Data]?) {
        let url = ProductAPI.promo + "/" + id
        
         WebServices.shared.requestToImageUpload(type: CreateProductEntity.self, with: url, imageData: imageData, showLoader: true, params: param) { [weak self] (response) in
             guard let self = self else {
                 return
             }
             if let response = response?.value {
                 self.accountPresenter?.editPromoSuccess(editProductEntity: response)
             }
         }
    }
    
    func getPromoList(id: String, isShowLoader: Bool) {
//        let productList =  AccountAPI.promocode + ProductConstant.hash + String(AppManager.shared.storeId ?? 0) + "?page=" + id
        let productList =  AccountAPI.promocode
        WebServices.shared.requestToApi(type: GetPromoCodeEntity.self, with: productList, urlMethod: .get, showLoader: isShowLoader,params: nil, encode: URLEncoding.default) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.accountPresenter?.getPromoSuccess(getPromoCodeEntity: response)
            }
        }
    }
    
    func deletePromo(promoId: Int) {
        let productApi =  AccountAPI.promocode + ProductConstant.hash + promoId.toString()
        WebServices.shared.requestToApi(type: CreateAddonsEntity.self, with: productApi, urlMethod: .delete, showLoader: true,params: nil) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.accountPresenter?.deletePromoSuccess(deletePromoEntity: response)
            }
        }
    }
    
    
    var accountPresenter: AccountInteractorToAccountPresenterProtocol?
        
    func changePassword(param: Parameters) {
        WebServices.shared.requestToApi(type: SuccessEntity.self, with: AccountAPI.changePassword, urlMethod: .post, showLoader: true,params: param) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.accountPresenter?.changePassword(changePassword: response)
            }
        }
    }
    
    func toLogout() {
        WebServices.shared.requestToApi(type: LogoutEntity.self, with: AccountAPI.logout, urlMethod: .post, showLoader: true) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.accountPresenter?.getLogoutSuccess(logoutEntity: response)
            }
        }
    }
    
    func revenueList() {
        WebServices.shared.requestToApi(type: RevenueEntity.self, with: AccountAPI.revenue, urlMethod: .get, showLoader: true) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.accountPresenter?.getRevenueSuccess(revenueEntity: response)
            }
        }
    }
    
    func getEditTimingList() {
        WebServices.shared.requestToApi(type: EditTimingEntity.self, with: AccountAPI.editTiming, urlMethod: .get, showLoader: true) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.accountPresenter?.getEditTimingSuccess(editTimingEntity: response)
            }
        }
    }
    
    func getEditRestaurant() {
        let url = AccountAPI.editRestaurant + ProductConstant.hash + String(AppManager.shared.storeId ?? 0)
        WebServices.shared.requestToApi(type: EditRestaurantEntity.self, with: url, urlMethod: .get, showLoader: true) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.accountPresenter?.getEditRestaurantSuccess(editRestaurantEntity: response)
            }
        }
    }
    
    func editRestaurant(param: Parameters, imageData: [String : Data]?) {
        let url = AccountAPI.editRestaurant + ProductConstant.hash + String(AppManager.shared.storeId ?? 0)
        
        WebServices.shared.requestToImageUpload(type: CreateAddonsEntity.self, with: url, imageData: imageData, showLoader: true, params: param) { [weak self] response in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.accountPresenter?.editRestaurantSuccess(editRestaurantEntity: response)
            }
        }
    }
    
    func editTiming(param: Parameters) {
        let url = AccountAPI.editTiming
        
        WebServices.shared.requestToApi(type: CreateAddonsEntity.self, with: url, urlMethod: .post, showLoader: true, params: param,accessTokenAdd: true) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.accountPresenter?.editTimingSuccess(editTimingEntity: response)
            }
        }
    }
    func resetPassword(param: Parameters) {
        WebServices.shared.requestToApi(type: ResetPasswordEntity.self, with: LoginAPI.resetPassword, urlMethod: .post, showLoader: true, params: param) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.accountPresenter?.resetPasswordSuccess(resetPasswordEntity: response)
            }
        }
    }
}
