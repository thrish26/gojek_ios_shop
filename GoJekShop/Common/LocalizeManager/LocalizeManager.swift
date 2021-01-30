//
//  LocationManager.swift
//  GoJekUser
//
//  Created by Sravani on 22/05/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import UIKit

enum Language : String, Codable, CaseIterable {
    case english = "en"
    case arabic = "ar"
    var code : String {
        switch self {
        case .english:
            return "en"
        case .arabic:
            return "ar"
        }
    }
    
        var title : String {
            switch self {
            case .english:
                return Constant.English
            case .arabic:
                return Constant.Arabic
            }
        }
    
    static var count: Int{ return 2 }
}


class LocalizeManager {
    
    static var share = LocalizeManager()
    var selectedLanguage : Language = .english
    
     func changeLocalization(language:Language) {
        let defaults = UserDefaults.standard
        defaults.set(language.rawValue, forKey: "Language")
        UserDefaults.standard.synchronize()
    }
    
     func currentlocalization() -> String {
        if let savedLocale = UserDefaults.standard.object(forKey: "Language") as? String {
            return savedLocale
        }
        return Language.english.rawValue
    }
    
     func currentLanguage() -> String{
        
        switch currentlocalization() {
        case Language.english.rawValue:
            return Constant.English.localize()
        case Language.arabic.rawValue:
            return Constant.Arabic.localize()
            
        default:
            return ""
        }
    }
    
    func setLocalization(language : Language){
        
        if let path = Bundle.main.path(forResource: language.code, ofType: "lproj"), let bundle = Bundle(path: path) {
            let attribute : UISemanticContentAttribute = language == .arabic ? .forceRightToLeft : .forceLeftToRight
            UIView.appearance().semanticContentAttribute = attribute
            selectedLanguage = language
            currentBundle = bundle
        } else {
            currentBundle = .main
        }
    }
}
