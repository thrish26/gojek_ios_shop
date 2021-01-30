//
//  OrdersInteractor.swift
//  GoJekUser
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire

class OrderInteractor: OrderPresenterToOrderInteractorProtocol {
    
    var orderPresenter: OrderInteractorToOrderPresenterProtocol?
    
    func getHistoryList(isHideLoader: Bool, page: Int,type: String){
        let url = OrderAPI.getHistory + "?type=" + type + "&page=" + String(page)
        WebServices.shared.requestToApi(type: HistoryEntity.self, with: url, urlMethod: .get, showLoader: isHideLoader) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.orderPresenter?.getHistory(historyEntity: response)
            }
        }
    }
    
    func getHistoryDetailList(id: Int){
        let url = OrderAPI.orderDetailHistory + id.toString()
        WebServices.shared.requestToApi(type: HistoryDetailEntity.self, with: url, urlMethod: .get, showLoader: true) { [weak self] (response) in
            guard let self = self else {
                return
            }
            if let response = response?.value {
                self.orderPresenter?.getHistoryDetail(historyDetailEntity: response)
            }
        }
    }
     func OrdertakeawayPickedup(param: Parameters){

           WebServices.shared.requestToApi(type: TakeAwayPickedupEntity.self, with: OrderAPI.takeawayDispatch, urlMethod: .post, showLoader: true,params: param) { [weak self] (response) in
               guard let self = self else {
                   return
               }
               if let response = response?.value {
                   self.orderPresenter?.OrdertakeawayPickedup(takeAwayPickedupEntity: response)
               }
           }
       
        }
    
}

