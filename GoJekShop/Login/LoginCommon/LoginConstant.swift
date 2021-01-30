//
//  LoginConstant.swift
//  GoJekUser
//
//  Created by Ansar on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation

enum LoginConstant {
    
    //MARK: - String

    static let loginVia = "Login Via"
    static let forgotPassword = "Forgot Password"
    static let cannotMakeCallAtThisMoment = "Cannot make call at this moment"
    static let couldnotOpenEmailAttheMoment = "Could not open Email at the moment."
    static let forgotPwdVia = "Forgot Password Via"
    static let or = "or"


    //Validation
    static let emailEmpty = "Enter Email Id"
    static let phoneEmpty = "Enter Phone Number"
    static let passwordEmpty = "Enter Password"
    static let validEmail = "Enter valid email id"
    static let validPhone = "Enter valid phone number"
    static let passwordlength = "Password Must have Atleast 6 Characters."
    static let enterNewPassword = "Enter new password"
    static let enterOldPassword = "Enter old password"
    static let enterConfirmPassword = "Enter confirm password"
    static let passwordNotSame = "Old password and new password not be same"
    static let passwordSame = "New password and confirm password should be same"
    
    //MARK: - CustomView
    static let WalkThroughCell = "WalkThroughCell"
    static let PaymentView = "PaymentView"
    static let CountryListCell = "CountryListCell"
    
    //MARK: - Viewcontroller Identifier
    static let SignInController = "SignInController"
    static let SplashViewController = "SplashViewController"
    static let ForgotPasswordController = "ForgotPasswordController"
    
    //MARK:- Image Names
    static let phone = "ic_phone"
    static let mail = "ic_mail"
    static let back = "ic_back"
    static let faceBookImage = "ic_facebook"
    static let googleImage = "ic_google"
    static let couponImage = "icnCoupon"
    static let searchImage = "search"
    static let soicalLoginmessage = "Please signup this account."
    
    //Sigin
    static let email = "email"
    static let password = "password"
    static let salt_key = "salt_key"
    static let device_token = "device_token"
    static let device_type = "device_type"
    static let old_password = "old_password"
    static let password_confirmation = "password_confirmation"
    
    //forgot password
    static let account_type = "account_type"
    static let otp = "otp"
    static let username = "username"
    static let country_code = "country_code"
    static let mobile = "mobile"

}

struct Country: Decodable {
    
    var name : String
    var dial_code : String
    var code : String
}

enum gender: String {
    case male = "MALE"
    case female = "FEMALE"
}

enum accountType: String {
    case email = "email"
    case mobile = "mobile"
}

enum userType: String {
    case user = "user"
    case Provider = "provider"
}

enum CoreDataEntity: String {
    case userData = "UserData"
    case loginData = "LoginData"
}

class StoreLoginData {
    static var shared = StoreLoginData()
    private init() {}
    
    var storeId: Int?
    
    func clear() {
        storeId = nil
    }
}

struct LoginAPI {
    static let signIn = "/shop/login"
    static let forgotPassword = "/shop/forgotOtp"
    static let resetPassword = "/shop/resetOtp"

}


