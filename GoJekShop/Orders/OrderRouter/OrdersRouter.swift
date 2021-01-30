//
//  OrdersRouter.swift
//  GoJekUser
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class OrderRouter: OrderPresenterToOrderRouterProtocol {
   
    static func createOrdersModule() -> UIViewController {
        
        let ordersViewController  = orderStoryboard.instantiateViewController(withIdentifier: OrderConstant.VOrdersController) as! OrdersController
        let ordersPresenter: OrderViewToOrderPresenterProtocol & OrderInteractorToOrderPresenterProtocol = OrderPresenter()
        let ordersInteractor: OrderPresenterToOrderInteractorProtocol = OrderInteractor()
        let ordersRouter: OrderPresenterToOrderRouterProtocol = OrderRouter()
        
        ordersViewController.ordersPresenter = ordersPresenter
        ordersPresenter.orderView = ordersViewController
        ordersPresenter.orderRouter = ordersRouter
        ordersPresenter.orderInteractor = ordersInteractor
        ordersInteractor.orderPresenter = ordersPresenter
        
        return ordersViewController
    }
    
    static var orderStoryboard: UIStoryboard {
        return UIStoryboard(name:"Order",bundle: Bundle.main)
    }
    
}
