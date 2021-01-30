//
//  OrdersPresenter.swift
//  GoJekUser
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire

class OrderPresenter: OrderViewToOrderPresenterProtocol {
    
    var orderView: OrderPresenterToOrderViewProtocol?
    
    var orderInteractor: OrderPresenterToOrderInteractorProtocol?
    
    var orderRouter: OrderPresenterToOrderRouterProtocol?
    func OrdertakeawayPickedup(param: Parameters) {
    orderInteractor?.OrdertakeawayPickedup(param: param)
    }
    
    func getHistoryList(isHideLoader: Bool, page: Int,type: String){
        orderInteractor?.getHistoryList(isHideLoader: isHideLoader, page: page,type: type)
    }
    
    func getHistoryDetailList(id: Int){
        orderInteractor?.getHistoryDetailList(id: id)
    }
    
}

extension OrderPresenter: OrderInteractorToOrderPresenterProtocol {
    func OrdertakeawayPickedup(takeAwayPickedupEntity: TakeAwayPickedupEntity) {
         orderView?.OrdertakeawayPickedup(takeAwayPickedupEntity: takeAwayPickedupEntity)
      }
    func getHistoryDetail(historyDetailEntity: HistoryDetailEntity) {
        orderView?.getHistoryDetail(historyDetailEntity: historyDetailEntity)
    }
    
    func getHistory(historyEntity: HistoryEntity) {
        orderView?.getHistory(historyEntity: historyEntity)
    }
    
    
    
    
}
