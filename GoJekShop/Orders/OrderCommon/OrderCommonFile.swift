//
//  OrderCommonFile.swift
//  GoJekUser
//
//  Created by apple on 22/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

enum OrderConstant {
    
    //Title
    static let history = "History"
    
    //OrderDetail
   
    static let orders = "Orders"
    static let takeaway = "TAKEAWAY"
    static let orderReady = "ORDER READY"
    
    static let orderPlaced = "Order Placed"
    static let orderPlacedInfo = "We have recieved your order"
    static let orderConfirmed = "Order Confirmed"
    static let orderConfirmedInfo = "Your order has been scheduled"
    static let orderProcessed = "Order Processed"
    static let orderProcessedInfo = "We are preparing your order"
    static let orderPickup = "Order Pickedup"
    static let orderPickupInfo = "Your order is ready to pickup"
    static let orderDelivered = "Order Delivered"
    static let orderDeliveredInfo = "Your order is delivered sucessfully"
    static let orderCancel = "Order Cancelled"
    static let noOngoingOrder = "You have no Ongoing Orders"
    static let noPastOrder = "You have no Past Orders"
    static let noCancelledOrder = "You have no Cancelled Orders"
    
    static let pastOrder = "Past"
    static let cancelOrder = "Cancel"
    static let ongoingOrder = "Current"
    
    //Identifier
    static let VOrderTableViewCell = "OrderTableViewCell"
    static let TOrderStatusCell = "OrderStatusCell"
    static let VOrdersController = "OrdersController"
    static let VOrderDetailController  = "OrderDetailController"
    static let TOrderListCell = "OrderListCell"
    
    
    
    
    //Image name
    
    static let ic_desktop = "desktop"
    static let ic_discount = "discount"
    static let ic_payment = "payment"
    static let ic_security = "security"
    static let ic_truck = "truck"
    static let ic_no_history = "ic_no_history"
    
    ///Parameter
    static let limit = "limit"
    static let offSet = "offset"
    static let type = "type"
    static let id = "id"
    static let dispute_type = "dispute_type"
    static let provider_id = "provider_id"
    static let dispute_name = "dispute_name"
    static let lost_item_name = "lost_item_name"
    static let reason = "reason"
    static let store_order_id = "store_id"
    static let user_id = "user_id"
    static let dispute_id = "dispute_id"
}

struct OrderAPI {
    static let getHistory = "/shop/shoprequesthistory"
    static let orderDetailHistory = "/shop/requesthistory/"
     static let takeawayDispatch = "/shop/dispatcher/pickedup"
}



enum historyType:String {
    case ongoing = "Current"
    case past = "Past"
    case cancelled = "Cancel"
    
    var currentType: String {
        switch self {
        case .past:
            return "COMPLETED"
        case .ongoing:
            return "ONGOING"//ACCEPTED
        case .cancelled:
            return "CANCELLED"
        }
    }
}


