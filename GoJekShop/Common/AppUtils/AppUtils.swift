//
//  AppUtils.swift
//  GoJekUser
//
//  Created by apple on 18/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import MessageUI

class AppUtils: NSObject {
    
    //Singleton class
    static let shared = AppUtils()
    
    // Button Border with shadow Color
    func buttonShadow(button: UIButton, viewCornerRadius: CGFloat) {
        button.layer.cornerRadius = CGFloat(viewCornerRadius)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize.zero
    }
    
    //Make Call
    
    func call(to number : String?) {
        
        if let phoneNumber = number, let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            AppAlert.shared.simpleAlert(view: UIApplication.topViewController() ?? UIViewController(), title: LoginConstant.cannotMakeCallAtThisMoment.localized, message: "")
        }
    }
    
    //Get Countries from JSON
    func getCountries()->[Country]{
        var source: [Country] = []
        if let data = NSData(contentsOfFile: Bundle.main.path(forResource: "countryCodes", ofType: "json") ?? "") as Data? {
            do{
                source = try JSONDecoder().decode([Country].self, from: data)
            } catch let err {
                print(err.localizedDescription)
            }
        }
        return source
    }
    
    // Method to convert JSON String to Dictionary
    func stringToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func dateToStringAm(dateStr: String) -> String {
        
        let baseConfig = AppConfigurationManager.shared.baseConfigModel

         let dateFormatter = DateFormatter()
         if baseConfig?.responseData?.appsetting?.date_format == "1" {
             dateFormatter.dateFormat = DateFormat.yyyy_mm_dd_hh_mm_ss

         }else{
             dateFormatter.dateFormat = DateFormat.dd_mm_yyyy_hh_mm_ss_a

         }
        let dateFromString = dateFormatter.date(from: dateStr)
        guard let currentDate = dateFromString else {
            return ""
        }
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = DateFormat.ddmmyyyy
        let stringFromDate = dateFormatter2.string(from: currentDate)
        return stringFromDate
    }
    //Email Validation
       func isValidEmail(emailStr: String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: emailStr)
       }
      
}



