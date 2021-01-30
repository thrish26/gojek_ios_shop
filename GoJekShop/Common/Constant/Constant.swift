//
//  Constant.swift
//  GoJekUser
//
//  Created by apple on 18/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

enum Constant {
    
    //View
    static let CustomTableCell = "CustomTableCell"
        
    //MARK:- String
    static let SOk = "OK"
    static let choose = "Choose"
    static let select = "Select"
    static let message = "message"
    static let SCancel = "Cancel"
    static let SAccept = "Accept"
    static let SopenCamera = "Open Camera"
    static let SopenGalley = "Open Gallery"
    static let SSave = "Save"
    static let SAdd = "Save"
    static let addpromo = "Add PromoCode"
    static let tempPromoDescription = "0% off, Max discount is 0"
    static let savepromo = "Save PromoCode"
    static let addPromo = "Add PromoCode"

    static let SYes = "Yes"
    static let SNo = "No"
    static let SName = "Name"
    static let promoCode = "PromoCode"
    static let other = "Others"
    static let noNetwork = "Please check your Internet conncection"
    static let choosePicture = "Choose your picture"
    static let writingSomething = "Write Something"
    static let password = "Password"
    static let passwordChangesMsg = "Your password has been changed. Please login with new password"
    static let removePhoto = "Remove Photo"
    static let SDelete = "delete"
    static let email = "Email"
    static let code = "Code"
    static let phoneNumber = "Phone Number"
    static let emailId = "Email Id"
    static let city = "City"
    static let country = "Country"
    static let lowStock = "Low Stock"
        
    //MARK: Images
    static let ic_error = "error"
    static let home = "ic_home"
    static let order = "ic_orders"
    static let account = "ic_account"
    static let eye = "ic_eye"
    static let eyeOff = "ic_eye_off"
    static let squareFill = "ic_square_fill"
    static let sqaureEmpty = "ic_square_empty"
    static let deleteImage = "ic_delete"
    static let circleImage = "ic_circle"
    static let circleFullImage = "ic_circle_full"
    static let checkImage = "ic_check"
    static let closeImage = "ic_close"
    static let phoneImage = "ic_phone"
    static let walletSmall = "ic_wallet"
    static let ic_location_pin = "ic_location_pin"
    static let ic_back = "ic_back"
    static let userPlaceholderImage = "ic_user"
    static let ic_product = "Product"
    static let notification = "ic_notification"
    static let imagePlaceHolder = "ImagePlaceHolder"
    
    //MARK:- Alert Mesage
    static let requestTimeOut = "Request time out"
        
    //Content Type
    static let RequestType = "X-Requested-With"
    static let RequestValue = "XMLHttpRequest"
    static let ContentType = "Content-Type"
    static let ContentValue = "application/json"
    static let Authorization = "Authorization"
    static let Bearer = "Bearer"
    static let multiPartValue = "multipart/form-data"
    static let errorCode = "statusCode"
    
    static let cameraPermission = "Unable to open camera, Check your camera permission"
    
    static let English = "English"
    static let Arabic = "Arabic"
    
    //MARK: - Socket Room
    static let CommonShopRoom = "joinShopRoom"
}

enum RoomListener: String {
    case NewRequest = "newRequest"
}

struct DateFormat {
    
    static let yyyy_mm_dd_hh_mm_ss = "yyyy-MM-dd HH:mm:ss"
    static let yyyy_mm_dd_hh_mm_ss_a = "yyyy-MM-dd HH:mm:ss"
    static let dd_mm_yyyy_hh_mm_ss = "dd-MM-yyyy HH:mm:ss"
    static let dd_mm_yyyy_hh_mm_ss_a = "dd-MM-yyyy hh:mm a"
    static let ddmmyyyy = "dd-MM-yyyy"
    static let ddMMMyy12 = "dd MMM yyyy, hh:mm a"
    static let ddMMMyy24 = "dd MMM yyyy, HH:mm:ss"
}
