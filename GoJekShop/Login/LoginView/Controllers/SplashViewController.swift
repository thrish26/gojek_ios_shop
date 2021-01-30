//
//  SplashViewController.swift
//  GoJekUser
//
//  Created by Rajes on 06/04/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire
import GooglePlaces

class SplashViewController: UIViewController {
    // var loginPresenter: LoginViewToLoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // loginPresenter = LoginRouter.createModule(controller: self)
        
        loginPresenter?.getBaseURL(param: [LoginConstant.salt_key: APPConstant.salt_key])
        
        // While launching splash if any internet problem means, once app comes to foreground this api will work
        NotificationCenter.default.addObserver(self, selector: #selector(appComesForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func appComesForeground(notification: NSNotification) {
        loginPresenter?.getBaseURL(param: [LoginConstant.salt_key: APPConstant.salt_key])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func checkAlreadyLogin() -> Bool {
        let fetchData = try! PersistentManager.shared.context.fetch(LoginData.fetchRequest()) as? [LoginData]
        if (fetchData?.count ?? 0) <= 0 {
            return false
        }
        AppManager.shared.accessToken = fetchData?.first?.access_token
        AppManager.shared.storeId = fetchData?.first?.storeTypeId
        AppManager.shared.storeType = fetchData?.first?.storeType
        AppManager.shared.storeTypeid = fetchData?.first?.storeMainTypeId
        AppManager.shared.currency_symbol = fetchData?.first?.currency_symbol
        return (fetchData?.count ?? 0) > 0
    }
}

extension SplashViewController: LoginPresenterToLoginViewProtocol {
    
    func getBaseURLResponse(baseEntity: BaseEntity) {
        
        AppConfigurationManager.shared.baseConfigModel = baseEntity
        AppConfigurationManager.shared.setBasicConfig(data: baseEntity)
        if let accessToken = UserDefaults.standard.string(forKey: "AccessToken") {
            AppManager.shared.accessToken = accessToken
        }
        // getCountries()
        if checkAlreadyLogin() {
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            appDelegate.window?.rootViewController = TabBarController().listTabBarController()
            appDelegate.window?.makeKeyAndVisible()
        } else {
            let walkThroughViewcontroller =  LoginRouter.loginStoryboard.instantiateViewController(withIdentifier: LoginConstant.SignInController)
            navigationController?.pushViewController(walkThroughViewcontroller, animated: true)
        }
        GMSPlacesClient.provideAPIKey(baseEntity.responseData?.appsetting?.ios_key ?? "")
        
    }
    
    func failureResponse(failureData: Data) {
        let walkThroughViewcontroller =  LoginRouter.loginStoryboard.instantiateViewController(withIdentifier: LoginConstant.SignInController)
        navigationController?.pushViewController(walkThroughViewcontroller, animated: true)
    }
}
