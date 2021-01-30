//
//  DoubleExtension.swift
//  GoJekUser
//
//  Created by Ansar on 09/04/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    func setCurrency() -> String {
    //        let baseModel = AppManager.shared.getUserDetails()
    //        let currency = baseModel?.currency ?? ""
            return "\(AppManager.shared.currency_symbol ?? "")  \(String(format: "%.2f", removeNil(self)))"
        }
        
    
    func roundOff(_ point: Int) -> String {
        return "\(String(format: "%.\(point)f", removeNil(self)))"
    }
    
    func removeNil(_ value : Double?) -> Double{
        return value ?? 0
    }
    
    func toString() -> String {
        return "\(self)"
    }
    
    // Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Int {
    func toString() -> String {
        return "\(self)"
    }
    
    func isInt(string: String) -> Bool {
        return Int(string) != nil
    }
}
extension String {
    func setCurrency() -> String {
//        let baseModel = AppManager.shared.getUserDetails()
//               let currency = baseModel?.currency ?? ""
               return "\(AppManager.shared.currency_symbol ?? "") \(self)"
    }
}
