//
//  ProductPresenter.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Alamofire

//MARK:- ProductViewToProductPresenterProtocol

class ProductPresenter: ProductViewToProductPresenterProtocol {
   
   
    var productView: ProductPresenterToProductViewProtocol?
    var productInteractor: ProductPresenterToProductInteractorProtocol?
    var productRouter: ProductPresenterToProductRouterProtocol?
    
    func getAddonsList(param: Parameters,isShowLoader: Bool) {
        productInteractor?.getAddonsList(param: param, isShowLoader: isShowLoader)
    }
    
    func updateCategory(param: Parameters, imageData: [String : Data]?,categoryId: Int) {
        productInteractor?.updateCategory(param: param, imageData: imageData,categoryId: categoryId)
    }
    
    func getProductList(id: String,isShowLoader: Bool) {
        productInteractor?.getProductList(id: id, isShowLoader: isShowLoader)
    }
    
    func addCategory(param: Parameters, imageData: [String : Data]?)  {
        productInteractor?.addCategory(param: param, imageData: imageData) 
    }
    func editAddons(Id: String, param: Parameters) {
           productInteractor?.editAddons(Id: Id, param: param)
    }
       
    func addAddons(param: Parameters) {
        productInteractor?.addAddons(param: param)
    }
    
    func deleteAddons(addonsId: Int){
        productInteractor?.deleteAddons(addonsId: addonsId)
    }
    
    func getCategory(param: Parameters, isShowLoader: Bool) {
        productInteractor?.getCategory(param: param, isShowLoader: isShowLoader)
    }
    
    func deleteCategory(categoryId: Int) {
        productInteractor?.deleteCategory(categoryId: categoryId)
    }
    
    func addProduct(param: Parameters, imageData: [String : Data]?)  {
        productInteractor?.addProduct(param: param,imageData: imageData)
    }
    func editProduct(param: Parameters,id: String, imageData: [String : Data]?) {
        productInteractor?.editProduct(param: param,id: id, imageData: imageData)

    }
    
    func deleteProduct(productId: Int) {
        productInteractor?.deleteProduct(productId: productId)
    }
    func getAddonsList(Id: String) {
        productInteractor?.getAddonsList(Id: Id)

    }
    func getUnits() {
        productInteractor?.getUnits()
       }
    
    func getAddons(){
        productInteractor?.getAddons()
    }
}

//MARK:- ProductInteractorToProductPresenterProtocol

extension ProductPresenter: ProductInteractorToProductPresenterProtocol {
    func editAddonsSuccess(editAddonsEntity: CreateAddonsEntity) {
        productView?.editAddonsSuccess(editAddonsEntity: editAddonsEntity)
    }
    
    func getUnitSuccess(unitEntity: UnitEntity) {
        productView?.getUnitSuccess(unitEntity: unitEntity)

    }
    func updateCategorySuccess(updateCategoryEntity: CreateAddonsEntity) {
        productView?.updateCategorySuccess(updateCategoryEntity: updateCategoryEntity)
    }
    
    func createAddonsSuccess(createAddonsEntity: CreateAddonsEntity) {
        productView?.createAddonsSuccess(createAddonsEntity: createAddonsEntity)
    }
    
    func getCategorySuccess(getCategoryEntity: GetCategoryEntity) {
        productView?.getCategorySuccess(getCategoryEntity: getCategoryEntity)
    }
    
    func getAddonsSuccess(addonsEntity: AddonsEntity) {
        productView?.getAddonsSuccess(addonsEntity: addonsEntity)
    }
    
    func deleteAddonsSuccess(deleteAddonsEntity: CreateAddonsEntity) {
        productView?.deleteAddonsSuccess(deleteAddonsEntity: deleteAddonsEntity)
    }
    
    func deleteCategorySuccess(deleteCategoryEntity: CreateAddonsEntity) {
        productView?.deleteCategorySuccess(deleteCategoryEntity: deleteCategoryEntity)
    }
    
    func createCategorySuccess(createCategoryEntity: CreateAddonsEntity){
        productView?.createCategorySuccess(createCategoryEntity: createCategoryEntity)
    }
    
    func createProductSuccess(createProductEntity: CreateProductEntity) {
        productView?.createProductSuccess(createProductEntity: createProductEntity)
    }
    
    func editProductSuccess(editProductEntity: CreateProductEntity) {
        productView?.editProductSuccess(editProductEntity: editProductEntity)
    }
    
    func getProductSuccess(getProductEntity: GetProductEntity) {
        productView?.getProductSuccess(getProductEntity: getProductEntity)
    }
    
    func deleteProductSuccess(deleteProductEntity: CreateAddonsEntity) {
        productView?.deleteProductSuccess(deleteProductEntity: deleteProductEntity)
    }
    
    func getAddonsListSuccess(addonEntity: AddonsListEntity){
        productView?.getAddonsListSuccess(addonEntity: addonEntity)
    }
    
}
