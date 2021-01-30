//
//  ProductProtocol.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Alamofire

var productPresenterObject: ProductViewToProductPresenterProtocol?

// MARK:- ProductPresenterToProductViewProtocol

protocol ProductPresenterToProductViewProtocol: class {
    
    func getAddonsSuccess(addonsEntity: AddonsEntity)
    func createAddonsSuccess(createAddonsEntity: CreateAddonsEntity)
    func deleteAddonsSuccess(deleteAddonsEntity: CreateAddonsEntity)
    func getCategorySuccess(getCategoryEntity: GetCategoryEntity)
    func deleteCategorySuccess(deleteCategoryEntity: CreateAddonsEntity)
    func createCategorySuccess(createCategoryEntity: CreateAddonsEntity)
    func updateCategorySuccess(updateCategoryEntity: CreateAddonsEntity)
    func createProductSuccess(createProductEntity: CreateProductEntity)
    func deleteProductSuccess(deleteProductEntity: CreateAddonsEntity)
    func getProductSuccess(getProductEntity: GetProductEntity)
    func getAddonsListSuccess(addonEntity: AddonsListEntity)
    func editProductSuccess(editProductEntity: CreateProductEntity)
    func getUnitSuccess(unitEntity: UnitEntity)
    func editAddonsSuccess(editAddonsEntity: CreateAddonsEntity)

}

extension ProductPresenterToProductViewProtocol {
    var productPresenter: ProductViewToProductPresenterProtocol? {
        get {
            productPresenterObject?.productView = self
            return productPresenterObject
        }
        set(newValue) {
            productPresenterObject = newValue
        }
    }
    func getAddonsSuccess(addonsEntity: AddonsEntity) { return }
    func createAddonsSuccess(createAddonsEntity: CreateAddonsEntity) { return }
    func deleteAddonsSuccess(deleteAddonsEntity: CreateAddonsEntity) { return }
    func updateCategorySuccess(updateCategoryEntity: CreateAddonsEntity) { return }
    func getCategorySuccess(getCategoryEntity: GetCategoryEntity) { return }
    func deleteCategorySuccess(deleteCategoryEntity: CreateAddonsEntity) { return }
    func createCategorySuccess(createCategoryEntity: CreateAddonsEntity) { return }
    func getProductSuccess(getProductEntity: GetProductEntity) { return }
    func createProductSuccess(createProductEntity: CreateProductEntity) { return }
    func editProductSuccess(editProductEntity: CreateProductEntity) { return }
    func deleteProductSuccess(deleteProductEntity: CreateAddonsEntity) { return }
    func getAddonsListSuccess(addonEntity: AddonsListEntity) { return }
    func getUnitSuccess(unitEntity: UnitEntity) { return }
    func editAddonsSuccess(editAddonsEntity: CreateAddonsEntity) { return }

}

//MARK:- ProductInteractorToProductPresenterProtocol

protocol ProductInteractorToProductPresenterProtocol: class {
    func getAddonsSuccess(addonsEntity: AddonsEntity)
    func createAddonsSuccess(createAddonsEntity: CreateAddonsEntity)
    func deleteAddonsSuccess(deleteAddonsEntity: CreateAddonsEntity)
    func updateCategorySuccess(updateCategoryEntity: CreateAddonsEntity)
    func getCategorySuccess(getCategoryEntity: GetCategoryEntity)
    func deleteCategorySuccess(deleteCategoryEntity: CreateAddonsEntity)
    func createCategorySuccess(createCategoryEntity: CreateAddonsEntity)
    func getProductSuccess(getProductEntity: GetProductEntity)
    func deleteProductSuccess(deleteProductEntity: CreateAddonsEntity)
    func createProductSuccess(createProductEntity: CreateProductEntity)
    func editProductSuccess(editProductEntity: CreateProductEntity)
    func getAddonsListSuccess(addonEntity: AddonsListEntity)
    func getUnitSuccess(unitEntity: UnitEntity)
    func editAddonsSuccess(editAddonsEntity: CreateAddonsEntity)
    
}

//MARK:- ProductPresenterToProductInteractorProtocol

protocol  ProductPresenterToProductInteractorProtocol: class{
    
    var productPresenter: ProductInteractorToProductPresenterProtocol? { get set }
    
    func getAddonsList(param: Parameters,isShowLoader: Bool)
    func addAddons(param: Parameters)
    func deleteAddons(addonsId: Int)
    func updateCategory(param: Parameters, imageData: [String : Data]?,categoryId: Int)
    func getCategory(param: Parameters, isShowLoader: Bool)
    func deleteCategory(categoryId: Int)
    func addCategory(param: Parameters, imageData: [String : Data]?)
    func getProductList(id: String,isShowLoader: Bool)
    func deleteProduct(productId: Int)
    func addProduct(param: Parameters, imageData: [String : Data]?)
    func getAddons()
    func getUnits()
    func getAddonsList(Id: String)
    func editAddons(Id: String,param: Parameters)
     func editProduct(param: Parameters,id: String, imageData: [String : Data]?)
    
}


//MARK:- ProductViewToProductPresenterProtocol

protocol ProductViewToProductPresenterProtocol: class {
    
    var productView: ProductPresenterToProductViewProtocol? { get set }
    var productInteractor: ProductPresenterToProductInteractorProtocol? { get set }
    var productRouter: ProductPresenterToProductRouterProtocol? { get set }
    
    func getAddonsList(param: Parameters,isShowLoader: Bool)
    func addAddons(param: Parameters)
    func deleteAddons(addonsId: Int)
    func updateCategory(param: Parameters, imageData: [String : Data]?,categoryId: Int)
    func getCategory(param: Parameters, isShowLoader: Bool)
    func deleteCategory(categoryId: Int) 
    func addCategory(param: Parameters, imageData: [String : Data]?)
    func getProductList(id: String,isShowLoader: Bool)
    func deleteProduct(productId: Int)
    func addProduct(param: Parameters, imageData: [String : Data]?)
    func getAddons()
    func getUnits()
    func getAddonsList(Id: String)
    func editAddons(Id: String,param: Parameters)
    func editProduct(param: Parameters,id: String, imageData: [String : Data]?)
}

//MARK:- ProductPresenterToProductRouterProtocol

protocol ProductPresenterToProductRouterProtocol {
    static func createProductModule() -> UIViewController
}
