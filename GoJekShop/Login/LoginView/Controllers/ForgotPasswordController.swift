//
//  ForgotPasswordController.swift
//  GoJekProvider
//
//  Created by CSS on 23/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire

class ForgotPasswordController: UIViewController {
    
    @IBOutlet weak var outterView: UIView!
    @IBOutlet weak var forgotPasswordViaLabel: UILabel!
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var phoneview: UIView!
    @IBOutlet weak var mailImage: UIImageView!
    @IBOutlet weak var mailView: UIView!
    @IBOutlet weak var codeTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var forgotPasswordView: RoundedView!
    @IBOutlet weak var phoneNumberTextField: CustomTextField!
    
    @IBOutlet weak var contactAdminLabel: UILabel!
    //Is selected phone or email
    var isPhoneSelect = false
    let baseConfig = AppConfigurationManager.shared.baseConfigModel
    
    
    //Set country code and image
    private var countryDetail: Country? {
        didSet {
            if countryDetail != nil {
                self.codeTextField.text = "   \(countryDetail?.dial_code ?? "")"
                self.codeTextField.setFlag(imageStr: "CountryPicker.bundle/"+(countryDetail?.code ?? "US"))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initalLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

//MARK: - Methods

extension ForgotPasswordController {
    private func initalLoads(){
        addButtonActions()
        setColors()
        setCustomFont()
        setCustomLocalization()
        addDefaultCountryCode()
        setNavigationBar()
        forgotPasswordView.addShadow(radius: 3.0, color: .lightGray)
        
        contactAdminLabel.text = "Please Contact Admin\n" + " \(baseConfig?.responseData?.appsetting?.supportdetails?.contact_number?.first?.number ?? "")"
        
//        if baseConfig?.responseData?.appsetting?.send_email == 1 && baseConfig?.responseData?.appsetting?.send_sms == 1  {
//            contactAdminLabel.isHidden = true
//            mailView.isHidden = false
//            phoneview.isHidden = false
//            forgotPasswordView.isHidden = false
//            emailTextField.isHidden = true
//            phoneNumberTextField.isHidden = false
//            codeTextField.isHidden = false
//        }else if baseConfig?.responseData?.appsetting?.send_email == 1  && baseConfig?.responseData?.appsetting?.send_sms == 0  {
            emailTextField.isHidden = false
            phoneNumberTextField.isHidden = true
            codeTextField.isHidden = true
            contactAdminLabel.isHidden = true
            mailView.isHidden = false
            phoneview.isHidden = true
            forgotPasswordView.isHidden = false
            isPhoneSelect = false
      //  }
//        else if baseConfig?.responseData?.appsetting?.send_sms == 1  && baseConfig?.responseData?.appsetting?.send_email == 0  {
//            emailTextField.isHidden = true
//            phoneNumberTextField.isHidden = false
//            contactAdminLabel.isHidden = true
//            codeTextField.isHidden = false
//            mailView.isHidden = true
//            phoneview.isHidden = false
//            forgotPasswordView.isHidden = false
//            isPhoneSelect = true
//        }
//        else if baseConfig?.responseData?.appsetting?.send_email == 0 && baseConfig?.responseData?.appsetting?.send_sms == 0 {
//            emailTextField.isHidden = true
//            phoneNumberTextField.isHidden = true
//            codeTextField.isHidden = true
//            contactAdminLabel.isHidden = false
//            mailView.isHidden = true
//            phoneview.isHidden = true
//            forgotPasswordView.isHidden = true
//        }
    }
    
    private func setNavigationBar() {
        self.setNavigationTitle()
        self.setLeftBarButtonWith(color: .blackColor)
        self.title = LoginConstant.forgotPassword.localized
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    // Set Colors
    private func setColors() {
        self.forgotPasswordView.backgroundColor = .appPrimaryColor
        self.forgotPasswordView.centerImageView.imageTintColor(color1: .white)
        self.outterView.backgroundColor = .boxColor
        self.view.backgroundColor = .backgroundColor
        
    }
    // Set Button Actions
    private func addButtonActions(){
        let forgotPassword = UITapGestureRecognizer(target: self, action: #selector(tapForgotPassword))
        self.forgotPasswordView.addGestureRecognizer(forgotPassword)
        let phoneViewGesture = UITapGestureRecognizer(target: self, action: #selector(tapPhoneEmail(_:)))
        self.phoneview.addGestureRecognizer(phoneViewGesture)
        let mailViewGesture = UITapGestureRecognizer(target: self, action: #selector(tapPhoneEmail(_:)))
        self.mailView.addGestureRecognizer(mailViewGesture)
        textfieldUIUpdate()
    }
    
    
    
    //Set localize sting
    private func setCustomLocalization() {
        
        self.forgotPasswordViaLabel.text = LoginConstant.forgotPwdVia.localized
        //Placeholder text
        self.emailTextField.placeholder = Constant.email.localized
        self.codeTextField.placeholder = Constant.code.localized
        self.codeTextField.fieldShapeType = .Left
        self.phoneNumberTextField.placeholder = Constant.phoneNumber.localized
        self.phoneNumberTextField.fieldShapeType = .Right
    }
    
    private func textfieldUIUpdate() {
        self.view.endEditing()
        emailTextField.text = String.empty
        phoneNumberTextField.text = String.empty
        
        if self.isPhoneSelect {
            self.phoneImage.imageTintColor(color1: .appPrimaryColor)
            self.mailImage.imageTintColor(color1: .lightGray)
            self.phoneview.backgroundColor = UIColor.appPrimaryColor.withAlphaComponent(0.1)
            self.mailView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
            self.phoneNumberTextField.isHidden = false
            self.codeTextField.isHidden = false
            self.emailTextField.isHidden = true
        }else {
            self.mailImage.imageTintColor(color1: .appPrimaryColor)
            self.phoneImage.imageTintColor(color1: .lightGray)
            self.phoneview.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
            self.mailView.backgroundColor = UIColor.appPrimaryColor.withAlphaComponent(0.1)
            self.phoneNumberTextField.isHidden = true
            self.codeTextField.isHidden = true
            self.emailTextField.isHidden = false
        }
    }
    
    
    @objc func tapForgotPassword() {
        self.view.endEditing()
        if validation() {
            var param:Parameters
            if isPhoneSelect {
                let countryCode = (codeTextField.text ?? "").dropFirst()
                param = [LoginConstant.account_type: accountType.mobile.rawValue,
                         LoginConstant.mobile:self.phoneNumberTextField.text!,
                         LoginConstant.country_code: countryCode.trimmingCharacters(in: .whitespacesAndNewlines),
                         LoginConstant.salt_key: APPConstant.salt_key]
            }else{
                param = [LoginConstant.account_type: accountType.email.rawValue,
                         LoginConstant.email: self.emailTextField.text!,
                         LoginConstant.salt_key: APPConstant.salt_key]
            }
            self.loginPresenter?.forgotPassword(param: param)
        }
    }
    
    //Validation
    private func validation() -> Bool {
        
//        if baseConfig?.responseData?.appsetting?.send_email == 1 && baseConfig?.responseData?.appsetting?.send_sms == 1  {
//            if isPhoneSelect {
//                guard let phoneStr = phoneNumberTextField.text?.trimString(), !phoneStr.isEmpty else {
//                    AppAlert.shared.simpleAlert(view: self, title: LoginConstant.phoneEmpty.localized, message: nil)
//                    return false
//                }
//                guard phoneStr.isPhoneNumber else{
//                    AppAlert.shared.simpleAlert(view: self, title: LoginConstant.validPhone.localized, message: nil)
//                    return false
//                }
//            }else{
//                guard let emailStr = emailTextField.text?.trimString(), !emailStr.isEmpty else {
//                    AppAlert.shared.simpleAlert(view: self, title: LoginConstant.emailEmpty.localized, message: nil)
//                    return false
//                }
//                guard (AppUtils.shared.isValidEmail(emailStr: self.emailTextField.text!)) else {
//                    AppAlert.shared.simpleAlert(view: self, title: LoginConstant.validEmail.localized, message: nil)
//                    return false
//                }
//            }
//        }else if baseConfig?.responseData?.appsetting?.send_email == 1  && baseConfig?.responseData?.appsetting?.send_sms == 0 {
//
            guard let emailStr = emailTextField.text?.trimString(), !emailStr.isEmpty else {
                AppAlert.shared.simpleAlert(view: self, title: LoginConstant.emailEmpty.localized, message: nil)
                return false
            }
            guard (AppUtils.shared.isValidEmail(emailStr: self.emailTextField.text!)) else {
                AppAlert.shared.simpleAlert(view: self, title: LoginConstant.validEmail.localized, message: nil)
                return false
            }
            
//        }else if baseConfig?.responseData?.appsetting?.send_sms == 1 && baseConfig?.responseData?.appsetting?.send_email == 0  {
//            guard let phoneStr = phoneNumberTextField.text?.trimString(), !phoneStr.isEmpty else {
//                AppAlert.shared.simpleAlert(view: self, title: LoginConstant.phoneEmpty.localized, message: nil)
//                return false
//            }
//            guard phoneStr.isPhoneNumber else{
//                AppAlert.shared.simpleAlert(view: self, title: LoginConstant.validPhone.localized, message: nil)
//                return false
//            }
//        }
        return true
    }
    
    private func addDefaultCountryCode() {
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            let countryCodeList = AppUtils.shared.getCountries()
            for eachCountry in countryCodeList {
                if countryCode == eachCountry.code {
                    self.countryDetail = Country(name: eachCountry.name, dial_code: eachCountry.dial_code, code: eachCountry.code)
                }
            }
        }
    }
}

//MARK: - Methods

extension ForgotPasswordController {
    
    //Login with mobile or email
    @objc func tapPhoneEmail(_ sender: UITapGestureRecognizer) {
        isPhoneSelect = sender.view?.tag == 1 ? true : false
        textfieldUIUpdate()
    }
    
    // set custom font
    private func setCustomFont() {
        self.emailTextField.font = UIFont.setCustomFont(name: .light, size: .x16)
        self.codeTextField.font = UIFont.setCustomFont(name: .light, size: FontSize.x16)
        self.phoneNumberTextField.font = UIFont.setCustomFont(name: .light, size: .x16)
        self.forgotPasswordViaLabel.font = UIFont.setCustomFont(name: .bold, size: .x18)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing()
    }
}

//MARK: - Textfield delegate
extension ForgotPasswordController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case codeTextField:
//            let countryCodeView = LoginRouter.loginStoryboard.instantiateViewController(withIdentifier: LoginConstant.CountryCodeViewController) as! CountryCodeViewController
//            countryCodeView.pickerType = .countryCode
//            countryCodeView.countryCode = { [weak self] countryDetail in
//                guard let self = self else {
//                    return
//                }
//                self.countryDetail = countryDetail
//            }
//            self.present(countryCodeView, animated: true, completion: nil)
            return false
        default:
            break
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.phoneNumberTextField && (textField.text?.count ?? 0) > 19 && !string.isEmpty  {
            return false
        }
        
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        return true
    }
}

extension ForgotPasswordController: LoginPresenterToLoginViewProtocol {
    
    func forgotPasswordSuccess(forgotPasswordEntity: ForgotPasswordEntity) {
        let vc = AccountRouter.createChangePasswordModule(isFromforgotPwd: true,otpString: forgotPasswordEntity.forgotPasswordData?.otp?.toString() ?? "",accountType: isPhoneSelect ? accountType.mobile : accountType.email,emailOrPhone: isPhoneSelect ? phoneNumberTextField.text! : emailTextField.text!,countryCode: String(isPhoneSelect ? codeTextField.text!.trimString().dropFirst() : ""))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
