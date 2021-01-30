//
//  StringExtension.swift
//  GoJekUser
//
//  Created by Ansar on 22/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import UIKit

var currentBundle: Bundle!

extension String {
    
    //Check sting is empty
    static var empty: String {
        return ""
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
        
    //If sting have value or not
    static func removeNil(_ value : String?) -> String{
        return value ?? String.empty
    }
   
    //Change localise language
    func localize()->String{
        return NSLocalizedString(self, bundle: currentBundle!, comment: "")
    }
    
    //Mark:- Localize String varibale
    var localized: String {
        
        guard let path = Bundle.main.path(forResource: LocalizeManager.share.currentlocalization(), ofType: "lproj") else {
            return NSLocalizedString(self, comment: "returns a chosen localized string")
        }
        let bundle = Bundle(path: path)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        
    }
    
    
    //Make first letter has capital letter
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    //Make first letter capital
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
   
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func trimString() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isValidPassword: Bool {
        return self.count >= 6
    }
    
    func toDate(withFormat format: String = DateFormat.yyyy_mm_dd_hh_mm_ss)-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
        
    }
    var isPhoneNumber: Bool {
           do {
               let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
               let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
               if let res = matches.first {
                   return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
               } else {
                   return false
               }
           } catch {
               return false
           }
       }
    
    func dateDiff() -> String {
        let format:DateFormatter = DateFormatter()
        format.dateFormat = DateFormat.yyyy_mm_dd_hh_mm_ss
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = DateFormat.yyyy_mm_dd_hh_mm_ss
        let showDate = inputFormatter.date(from: self)
        
        let date1:Date = showDate!
        let date2: Date = Date()
        let calendar: Calendar = Calendar.current
        
        let components: DateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date1, to: date2)
        
        let weeks = Int(components.month!)
        let days = Int(components.day!)
        let hours = Int(components.hour!)
        let min = Int(components.minute!)
        let sec = Int(components.second!)
        let year = Int(components.year!)
        
        var timeAgo = ""
        if sec == 0 {
            timeAgo = "just now"
        }else if (sec > 0){
            if (sec >= 2) {
                timeAgo = "\(sec) secs ago"
            } else {
                timeAgo = "\(sec) sec ago"
            }
        }
        
        if (min > 0){
            if (min >= 2) {
                timeAgo = "\(min) mins ago"
            } else {
                timeAgo = "\(min) min ago"
            }
        }
        
        if(hours > 0){
            if (hours >= 2) {
                timeAgo = "\(hours) hrs ago"
            } else {
                timeAgo = "\(hours) hr ago"
            }
        }
        
        if (days > 0) {
            if (days >= 2) {
                timeAgo = "\(days) days ago"
            } else {
                timeAgo = "\(days) day ago"
            }
        }
        
        if(weeks > 0){
            if (weeks >= 2) {
                timeAgo = "\(weeks) months ago"
            } else {
                timeAgo = "\(weeks) month ago"
            }
        }
        
        if(year > 0){
            if (year >= 2) {
                timeAgo = "\(year) years ago"
            } else {
                timeAgo = "\(year) year ago"
            }
        }
        return timeAgo;
    }
    
}
