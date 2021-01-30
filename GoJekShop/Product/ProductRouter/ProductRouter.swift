//
//  ProductRouter.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit

class ProductRouter: ProductPresenterToProductRouterProtocol {
    static func createProductModule() -> UIViewController {
        let productViewController  = productStoryboard.instantiateViewController(withIdentifier: ProductConstant.VDishViewController) as! DishViewController
        let productPresenter: ProductViewToProductPresenterProtocol & ProductInteractorToProductPresenterProtocol = ProductPresenter()
        let productInteractor: ProductPresenterToProductInteractorProtocol = ProductInteractor()
        let productRouter: ProductPresenterToProductRouterProtocol = ProductRouter()
        
        productViewController.productPresenter = productPresenter
        productPresenter.productView = productViewController
        productPresenter.productRouter = productRouter
        productPresenter.productInteractor = productInteractor
        productInteractor.productPresenter = productPresenter
        return productViewController
    }
    
    static var productStoryboard: UIStoryboard {
        return UIStoryboard(name:"Product",bundle: Bundle.main)
    }
}
