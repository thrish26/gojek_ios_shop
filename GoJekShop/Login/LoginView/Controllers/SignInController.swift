//
//  SignInController.swift
//  GoJekUser
//
//  Created by Ansar on 21/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire
var isDarkMode = false

class SignInController: UIViewController {
    
    @IBOutlet weak var outterView: UIView!
    @IBOutlet weak var topView:UIView!
    @IBOutlet weak var mailTextFieldView:UIView!
    @IBOutlet weak var signInView:RoundedView!
    @IBOutlet weak var showPasswordButton:UIButton!
    @IBOutlet weak var loginViaLabel:UILabel!
    
    //Textfield
    @IBOutlet weak var passwordTextField:CustomTextField!
    @IBOutlet weak var emailTextField:CustomTextField!
    @IBOutlet weak var forgotPasswordButton:UIButton!
    private var accessToken : String?
    var firstName = ""
    var lastName = ""
    var email = ""
    var profileImage = ""
    
    var isShowPassword:Bool = false {
        didSet {
            passwordTextField.isSecureTextEntry = isShowPassword
            showPasswordButton.setImage(UIImage(named: isShowPassword ? Constant.eyeOff : Constant.eye), for: .normal)
        }
    }
    var isPhoneSelect = false {
           didSet {
             //  phoneTextFieldView.isHidden = !isPhoneSelect
               mailTextFieldView.isHidden = isPhoneSelect
               textfieldUIUpdate()
           }
       }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topView.roundedTop(desiredCurve: topView.frame.height/3)
    }
}

//MARK: - Methods

extension SignInController {
    
    private func initialLoads(){
        signInView.addShadow(radius: 3.0, color: .lightGray)
        self.view.backgroundColor = .veryLightGray
        localize()
        setColors()
        showPasswordButton.addTarget(self, action: #selector(tapShowPassword), for: .touchUpInside)
//        passwordTextField.textColor = .black
        isShowPassword = true
        setFont()
        let signinGuesture = UITapGestureRecognizer(target: self, action: #selector(tapSignIn))
        signInView.addGestureRecognizer(signinGuesture)
        AppManager.shared.accessToken = ""
        UserDefaults.standard.set(nil, forKey: "AccessToken")
        forgotPasswordButton.addTarget(self, action: #selector(tapForgotPassword), for: .touchUpInside)
        setDarkMode()
        
    }
    
    func setDarkMode(){
        self.view.backgroundColor = .backgroundColor
        self.outterView.backgroundColor = .boxColor
        self.topView.backgroundColor = .boxColor

    }
    
    private func localize() {
        emailTextField.placeholder = Constant.email.localized
        loginViaLabel.text = LoginConstant.loginVia.localized
        passwordTextField.placeholder = Constant.password.localized
        forgotPasswordButton.setTitle(LoginConstant.forgotPassword.localized+"?", for: .normal)

    }
    
    private func setFont() {
        forgotPasswordButton.titleLabel?.font = .setCustomFont(name: .medium, size: .x14)

        loginViaLabel.font = .setCustomFont(name: .medium, size: .x20)
        passwordTextField.font = .setCustomFont(name: .medium, size: .x14)
        emailTextField.font = .setCustomFont(name: .medium, size: .x14)
    }
    
    private func setColors() {
        forgotPasswordButton.textColor(color: .blackColor)
        loginViaLabel.textColor = .blackColor
        signInView.backgroundColor = .appPrimaryColor
        signInView.centerImageView.imageTintColor(color1: .white)
    }
    
    private func textfieldUIUpdate() {
        passwordTextField.text = String.empty
        emailTextField.text = String.empty
        self.view.endEditing()
    }
    
    private func validation() -> Bool {
        guard let emailStr = emailTextField.text?.trimString(), !emailStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: LoginConstant.emailEmpty.localized, message: nil)
            return false
        }
        guard emailStr.isValidEmail() else {
            AppAlert.shared.simpleAlert(view: self, title: LoginConstant.validEmail.localized, message: nil)
            return false
        }
        guard let passwordStr = passwordTextField.text?.trimString(), !passwordStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: LoginConstant.passwordEmpty.localized, message: nil)
            return false
        }
        guard passwordStr.isValidPassword else {
            AppAlert.shared.simpleAlert(view: self, title: LoginConstant.passwordlength.localized, message: nil)
            return false
        }
        return true
    }
    
}

//MARK: - Actions

extension SignInController {
    @objc func tapSignIn() {
        signInView.addPressAnimation()
        self.view.endEditing()
        if validation() {
            var param: Parameters
            
                param = [LoginConstant.email:emailTextField.text!,
                         LoginConstant.password:passwordTextField.text!]
            
            param[LoginConstant.device_token] = deviceTokenString
            param[LoginConstant.device_type] = "IOS"
            
            loginPresenter?.signin(param: param)
        }
    }
    
    @objc func tapShowPassword() {
        isShowPassword = !isShowPassword
    }
    @objc func tapForgotPassword() {
           self.view.endEditing()
           let vc = LoginRouter.loginStoryboard.instantiateViewController(withIdentifier: LoginConstant.ForgotPasswordController) as! ForgotPasswordController
           vc.isPhoneSelect = false
           self.navigationController?.pushViewController(vc, animated: true)
       }
}

extension SignInController: UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordTextField && (textField.text?.count ?? 0) > 19 && !string.isEmpty  {
            
            return false
        }
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        return true
    }
    
}


extension SignInController: LoginPresenterToLoginViewProtocol {
    
    func signinSuccess(loginEntity: LoginEntity) {
        if let responseData = loginEntity.responseData {
            AppManager.shared.accessToken = responseData.access_token
            AppManager.shared.storeId = responseData.user?.id

            saveSignin(loginEntity: loginEntity)
            UserDefaults.standard.set(AppManager.shared.accessToken, forKey: "AccessToken")
            UserDefaults.standard.synchronize()
            CommonFunction.isFirstSignin = true
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            appDelegate.window?.rootViewController = TabBarController().listTabBarController()
            appDelegate.window?.makeKeyAndVisible()
            
        }
    }
    //To save coredata
    func saveSignin(loginEntity: LoginEntity) {
        let fetchData = try!PersistentManager.shared.context.fetch(LoginData.fetchRequest()) as? [LoginData]
        if fetchData?.count ?? 0 > 0 {
            PersistentManager.shared.delete(entityName: CoreDataEntity.loginData.rawValue)
        }
        let loginDetail = LoginData(context: PersistentManager.shared.persistentContainer.viewContext)
        loginDetail.access_token  = loginEntity.responseData?.access_token
        loginDetail.storeTypeId = loginEntity.responseData?.user?.id ?? 0
        loginDetail.currency_symbol = loginEntity.responseData?.user?.currency_symbol
        loginDetail.country_code = loginEntity.responseData?.user?.country_code ?? 0
        loginDetail.city_id = loginEntity.responseData?.user?.cityId ?? 0
        loginDetail.country_id = loginEntity.responseData?.user?.countryId ?? 0
        loginDetail.storeMainTypeId = Int64(loginEntity.responseData?.user?.store_type_id ?? 0)
        loginDetail.storeType = loginEntity.responseData?.user?.store_type ?? ""
        AppManager.shared.storeType = loginDetail.storeType
        AppManager.shared.storeTypeid = loginDetail.storeMainTypeId
          AppManager.shared.currency_symbol = loginDetail.currency_symbol
        PersistentManager.shared.saveContext()
        print(loginDetail)

    }
    
}
