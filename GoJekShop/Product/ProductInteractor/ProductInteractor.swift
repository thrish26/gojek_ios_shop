//
//  ProductInteractor.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Alamofire

class ProductInteractor: ProductPresenterToProductInteractorProtocol {
   
    
    
    var productPresenter: ProductInteractorToProductPresenterProtocol?
    
    func getAddonsList(param: Parameters,isShowLoader: Bool) {
        let addonList =  ProductAPI.addonsList + ProductConstant.hash + String(AppManager.shared.storeId ?? 0)
        WebServices.shared.requestToApi(type: AddonsEntity.self, with: addonList, urlMethod: .get, showLoader: isShowLoader,params: param, encode: URLEncoding.default) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.productPresenter?.getAddonsSuccess(addonsEntity: response)
            }
        }
    }
    
    func getProductList(id: String,isShowLoader: Bool) {
        let productList =  ProductAPI.productList + ProductConstant.hash + String(AppManager.shared.storeId ?? 0) + "?page=" + id
        WebServices.shared.requestToApi(type: GetProductEntity.self, with: productList, urlMethod: .get, showLoader: isShowLoader,params: nil, encode: URLEncoding.default) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.productPresenter?.getProductSuccess(getProductEntity: response)
            }
        }
    }
    func addAddons(param: Parameters) {
        WebServices.shared.requestToApi(type: CreateAddonsEntity.self, with: ProductAPI.addAddons, urlMethod: .post, showLoader: true,params: param) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.productPresenter?.createAddonsSuccess(createAddonsEntity: response)
            }
        }
    }
    
    func editAddons(Id: String,param: Parameters) {
        let url = ProductAPI.addAddons + ProductConstant.hash + Id
        WebServices.shared.requestToApi(type: CreateAddonsEntity.self, with: url, urlMethod: .post, showLoader: true,params: param) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.productPresenter?.createAddonsSuccess(createAddonsEntity: response)
            }
        }
    }
    
    func deleteAddons(addonsId: Int) {
        let addonList =  ProductAPI.addAddons + ProductConstant.hash + addonsId.toString()
        WebServices.shared.requestToApi(type: CreateAddonsEntity.self, with: addonList, urlMethod: .delete, showLoader: true,params: nil) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.productPresenter?.deleteAddonsSuccess(deleteAddonsEntity: response)
            }
        }
    }
    
    func updateCategory(param: Parameters, imageData: [String : Data]?,categoryId: Int) {
        let categoryApi = ProductAPI.category + ProductConstant.hash + categoryId.toString()
        WebServices.shared.requestToImageUpload(type: CreateAddonsEntity.self, with: categoryApi, imageData: imageData, showLoader: true, params: param) { [weak self] response in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.productPresenter?.updateCategorySuccess(updateCategoryEntity: response)
            }
        }
    }
    
    func deleteCategory(categoryId: Int) {
        let categoryApi =  ProductAPI.category + ProductConstant.hash + categoryId.toString()
        WebServices.shared.requestToApi(type: CreateAddonsEntity.self, with: categoryApi, urlMethod: .delete, showLoader: true,params: nil) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.productPresenter?.deleteCategorySuccess(deleteCategoryEntity: response)
            }
        }
    }
    
    func getCategory(param: Parameters, isShowLoader: Bool) {
        let categoryList  = ProductAPI.categoryIndex + ProductConstant.hash + String(AppManager.shared.storeId ?? 0)
        WebServices.shared.requestToApi(type: GetCategoryEntity.self, with: categoryList, urlMethod: .get, showLoader: isShowLoader,params: param, encode: URLEncoding.default) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.productPresenter?.getCategorySuccess(getCategoryEntity: response)
            }
        }
    }
    
    func addCategory(param: Parameters, imageData: [String : Data]?) {
        WebServices.shared.requestToImageUpload(type: CreateAddonsEntity.self, with: ProductAPI.category, imageData: imageData, showLoader: true, params: param) { [weak self] response in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.productPresenter?.createCategorySuccess(createCategoryEntity: response)
            }
        }
    }
    
    func editCategory(param: Parameters) {
        WebServices.shared.requestToApi(type: CreateAddonsEntity.self, with: ProductAPI.category, urlMethod: .post, showLoader: true,params: param) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.productPresenter?.createCategorySuccess(createCategoryEntity: response)
            }
        }
    }
    
    
    
    func addProduct(param: Parameters, imageData: [String : Data]?)   {
        let addProduct =  ProductAPI.product
        
        WebServices.shared.requestToImageUpload(type: CreateProductEntity.self, with: addProduct, imageData: imageData, showLoader: true, params: param) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.productPresenter?.createProductSuccess(createProductEntity: response)
            }
        }
    }
    
    func editProduct(param: Parameters,id: String, imageData: [String : Data]?) {
        let url = ProductAPI.product + "/" + id
       
        WebServices.shared.requestToImageUpload(type: CreateProductEntity.self, with: url, imageData: imageData, showLoader: true, params: param) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.productPresenter?.editProductSuccess(editProductEntity: response)
            }
        }
    }
    
    func deleteProduct(productId: Int) {
        let productApi =  ProductAPI.product + ProductConstant.hash + productId.toString()
        WebServices.shared.requestToApi(type: CreateAddonsEntity.self, with: productApi, urlMethod: .delete, showLoader: true,params: nil) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.productPresenter?.deleteProductSuccess(deleteProductEntity: response)
            }
        }
    }
    
    func getAddons() {
        let addonListApi =  ProductAPI.selectAddons + ProductConstant.hash + String(AppManager.shared.storeId ?? 0)
        WebServices.shared.requestToApi(type: AddonsListEntity.self, with: addonListApi, urlMethod: .get, showLoader: true,params: nil, encode: URLEncoding.default) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.productPresenter?.getAddonsListSuccess(addonEntity: response)
            }
        }
    }
    func getAddonsList(Id: String) {
        let addonListApi =  ProductAPI.selectAddons + ProductConstant.hash + String(AppManager.shared.storeId ?? 0) + ProductConstant.hash  + Id
        WebServices.shared.requestToApi(type: AddonsListEntity.self, with: addonListApi, urlMethod: .get, showLoader: true,params: nil, encode: URLEncoding.default) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.productPresenter?.getAddonsListSuccess(addonEntity: response)
            }
        }
    }
    func getUnits() {
          // let addonListApi =  ProductAPI.selectAddons + ProductConstant.hash + String(AppManager.shared.storeId ?? 0)
        WebServices.shared.requestToApi(type: UnitEntity.self, with: ProductAPI.unitList, urlMethod: .get, showLoader: true,params: nil, encode: URLEncoding.default) { [weak self] (response) in
               guard let self = self else {
                   return
               }
               if let response = response?.value {
                   self.productPresenter?.getUnitSuccess(unitEntity: response)
               }
           }
       }
}
