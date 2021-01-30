//
//  HomeConstant.swift
//  GoJekUser
//
//  Created by apple on 21/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

enum HomeConstant {
    
    //Viewcontroller Identifier
    static let VHomeViewController  = "HomeController"
    static let VHomeDetailController = "HomeDetailController"
    static let TUpcomingRequestTableViewCell  = "UpcomingRequestTableViewCell"
    static let TUpcomingDetailProfileCell = "UpcomingDetailProfileCell"
    static let TItemCell = "ItemCell"
    static let TDeliveryChargeCell = "DeliveryChargeCell"
    static let TDAddonsCell = "AddonsCell"
    
    //Viewcontrolle Title
    static let THome = "Home"
    static let TUpcomingTask = "WAITING FOR THE UPCOMING TASK"
    static let orderTime = "Order Time"
    static let waitingOrder = "Waiting for new orders"
    static let cancelContent = "Are you sure want to cancel the order?"
    static let orderDeliveryTime = "Order Delivery Time"
    static let reasonfor = "Reason For Cancellation"
    static let tellreason = "Tell us why you are cancelling the order"
    static let preparationTime = "Enter the order preparation time ?"
    static let preparationDate = "Select the Delivery date ?"
    static let chooseDate = "Choose Date"
    static let mins =  "Mins"
    static let selectDate = "select Date"
    static let incomingOrder = "Incoming Orders"
    static let acceptedOrder = "Accepted Orders"
    static let deliveryCharge = "Delivery Charge"
    static let coupon = "Coupon Amount"
    static let totalCharge = "Total Charge"
    static let discount = "Discount"
    static let storePackage = "Shop Package Charge"
    static let taxAmount = "Tax Amount"
    static let promoCode = "PromoCode"
    static let total = "Total"
    static let enterTime = "Enter the Time taken for cooking"
    static let enterCancel = "Enter cancel reason"
    static let upcomingRequest = "Upcoming Requests"
    static let TorderList = "Order List"
    static let TItemPrice = "Item Total"
    static let showMore = "Show More"
    static let showLess = "Show Less"
    //ImageName
    static let hourglass = "sands"
    static let location = "Location"
    static let takeaway = "takeaway"
    static let orderList = "orderList"
    static let ic_phone = "ic_phone"
    
    //Parameters
    static let type = "type"
    static let cooking_time = "cooking_time"
    static let store_order_id = "store_order_id"
    static let user_id = "user_id"
    static let id = "id"
    static let store_id = "store_id"
    static let cancel_reason = "cancel_reason"
}

enum HomeAPI {
    
    static let getUpcomingRequest = "/shop/dispatcher/orders"
    static let acceptRequest = "/shop/dispatcher/accept"
    static let cancelRequest = "/shop/dispatcher/cancel"
}

enum OrderType:String {
    case accepted = "Accepted"
    case ordered = "ordered"
    
    var currentType: String {
        switch self {
            case .accepted:
                return "ACCEPTED"
            case .ordered:
                return "ORDERED"
        }
    }
}
