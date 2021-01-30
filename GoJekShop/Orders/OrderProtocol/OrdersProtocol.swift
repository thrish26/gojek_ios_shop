//
//  OrdersProtocol.swift
//  GoJekUser
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire

var ordersPresenterObject: OrderViewToOrderPresenterProtocol?
// MARK:- Order Presenter to Order View Protocol

protocol OrderPresenterToOrderViewProtocol: class {
    
    func getHistory(historyEntity: HistoryEntity)
     func getHistoryDetail(historyDetailEntity: HistoryDetailEntity)
    func OrdertakeawayPickedup(takeAwayPickedupEntity: TakeAwayPickedupEntity)
}

extension OrderPresenterToOrderViewProtocol {
    var ordersPresenter: OrderViewToOrderPresenterProtocol? {
        get {
            ordersPresenterObject?.orderView = self
            return ordersPresenterObject
        }
        set(newValue) {
            ordersPresenterObject = newValue
        }
    }
    func getHistory(historyEntity: HistoryEntity) { return }
         func getHistoryDetail(historyDetailEntity: HistoryDetailEntity) { return }
     func OrdertakeawayPickedup(takeAwayPickedupEntity: TakeAwayPickedupEntity) {return}

}

//MARK:- Notification Interactor to Notification Presenter Protocol

protocol OrderInteractorToOrderPresenterProtocol: class {
    func getHistory(historyEntity: HistoryEntity)
    func getHistoryDetail(historyDetailEntity: HistoryDetailEntity)
    func OrdertakeawayPickedup(takeAwayPickedupEntity: TakeAwayPickedupEntity)

}


//MARK:- Notification Presenter To Notification Interactor Protocol

protocol OrderPresenterToOrderInteractorProtocol: class{
    
    var orderPresenter: OrderInteractorToOrderPresenterProtocol? { get set }
    
    func getHistoryList(isHideLoader: Bool, page: Int,type: String)
    func getHistoryDetailList(id: Int)
      func OrdertakeawayPickedup(param: Parameters)
}

//MARK:- Notification View To Notification Presenter Protocol

protocol OrderViewToOrderPresenterProtocol: class {
    
    var orderView: OrderPresenterToOrderViewProtocol? { get set }
    var orderInteractor: OrderPresenterToOrderInteractorProtocol? { get set }
    var orderRouter: OrderPresenterToOrderRouterProtocol? { get set }
    
     func getHistoryList(isHideLoader: Bool, page: Int,type: String)
    func getHistoryDetailList(id: Int)
     func OrdertakeawayPickedup(param: Parameters)
    
}

//MARK:- Notification Presenter To Notification Router Protocol

protocol OrderPresenterToOrderRouterProtocol: class {
    
}


