//
//  ChangePasswordController.swift
//  GoJekUser
//
//  Created by Ansar on 01/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire

class ChangePasswordController: UIViewController {
    
    @IBOutlet weak var oldPasswordTextField: CustomTextField!
    @IBOutlet weak var confirmPasswordTextField: CustomTextField!
    @IBOutlet weak var newPasswordTextField: CustomTextField!
    @IBOutlet weak var otpTextField: CustomTextField!
    
    @IBOutlet weak var oldShowPasswordButton: UIButton!
    @IBOutlet weak var confirmShowPasswordButton: UIButton!
    @IBOutlet weak var newShowPasswordButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var oldPasswordView: UIView!
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var newPasswordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var nextView: RoundedView!
    @IBOutlet weak var outterView: UIView!
    
    var isFromForgotPassword: Bool = false
    var myAccountPresenter:AccountViewToAccountPresenterProtocol!
    var otpString:String = ""
    
    var accountType:accountType = .email
    var emailOrPhone:String = ""
    var countryCode:String = ""
    
    var isShowOtp: Bool = false {
        didSet {
            otpView.isHidden = !isShowOtp
            newPasswordView.isHidden = isShowOtp
            confirmPasswordView.isHidden = isShowOtp
            nextView.isHidden = !isShowOtp
            saveButton.isHidden = isShowOtp
        }
    }
    
    var isHideOldPassword: Bool = false {
        didSet {
            oldPasswordTextField.isSecureTextEntry = isHideOldPassword
            oldShowPasswordButton.setImage(UIImage(named: isHideOldPassword ? Constant.eye : Constant.eyeOff), for: .normal)
        }
    }
    
    var isHideNewPassword:Bool = false {
        didSet {
            newPasswordTextField.isSecureTextEntry = isHideNewPassword
            newShowPasswordButton.setImage(UIImage(named: isHideNewPassword ? Constant.eye : Constant.eyeOff), for: .normal)
        }
    }
    
    var isHideConfirmPassword:Bool = false {
        didSet {
            confirmPasswordTextField.isSecureTextEntry = isHideConfirmPassword
            confirmShowPasswordButton.setImage(UIImage(named: isHideConfirmPassword ? Constant.eye : Constant.eyeOff), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLocalize()
        hideTabBar()
    }
}

//MARK: - Methods
extension ChangePasswordController{
    private func initialLoads() {
        self.setLeftBarButtonWith(color: .blackColor)
        otpTextField.placeholder = AccountConstant.otp
        nextView.addShadow(radius: 3.0, color: .lightGray)
        myAccountPresenter = AccountRouter.createModule(controller: self)
        saveButton.addTarget(self, action: #selector(tapSaveButton), for: .touchUpInside)
        confirmShowPasswordButton.addTarget(self, action: #selector(tapShowPassword(_:)), for: .touchUpInside)
        newShowPasswordButton.addTarget(self, action: #selector(tapShowPassword(_:)), for: .touchUpInside)
        oldShowPasswordButton.addTarget(self, action: #selector(tapShowPassword(_:)), for: .touchUpInside)
        let nextGesture = UITapGestureRecognizer(target: self, action: #selector(tapNext))
        self.nextView.addGestureRecognizer(nextGesture)
        saveButton.backgroundColor = .appPrimaryColor
        nextView.backgroundColor = .appPrimaryColor
        nextView.centerImageView.imageTintColor(color1: .white)
        self.view.backgroundColor = .backgroundColor
        DispatchQueue.main.async {
            self.saveButton.setBothCorner()
        }
       // otpTextField.text = otpString
        isShowOtp = isFromForgotPassword
        isHideNewPassword = true
        isHideConfirmPassword = true
        isHideOldPassword = true
        self.oldPasswordView.isHidden = isFromForgotPassword
        setNavigationBar()
        setFont()
        outterView.backgroundColor = .boxColor
    }
    
    func setTitle() {
        self.title = isFromForgotPassword ? (isShowOtp ? AccountConstant.otpVerification.localized : AccountConstant.resetPassword.localized) : AccountConstant.changePassword.localized
    }
    
    private func setLocalize() {
        confirmPasswordTextField.placeholder = AccountConstant.confirmPassword.localized
        newPasswordTextField.placeholder = AccountConstant.newPassword.localized
        oldPasswordTextField.placeholder = AccountConstant.oldPassword.localized
        saveButton.setTitle(Constant.SSave.localized, for: .normal)
    }
    
    private func setNavigationBar() {
        setNavigationTitle()
        setTitle()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    @objc func tapSaveButton() {
        let oldPasswordStr = oldPasswordTextField.text?.trimString()
        if !isFromForgotPassword {
            guard !(oldPasswordStr?.isEmpty ?? false) else {
                AppAlert.shared.simpleAlert(view: self, title: LoginConstant.enterOldPassword, message: nil)
                return
            }
            guard (oldPasswordStr?.isValidPassword ?? false) else {
                AppAlert.shared.simpleAlert(view: self, title: LoginConstant.passwordlength, message: nil)
                return
            }
        }
        
        guard let newPasswordStr = newPasswordTextField.text?.trimString(), !newPasswordStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: LoginConstant.enterNewPassword, message: nil)
            return
        }
        guard newPasswordStr.isValidPassword else {
            AppAlert.shared.simpleAlert(view: self, title: LoginConstant.passwordlength, message: nil)
            return
        }
        if !isFromForgotPassword {
            guard oldPasswordStr != newPasswordStr else {
                AppAlert.shared.simpleAlert(view: self, title: LoginConstant.passwordNotSame, message: nil)
                return
            }
        }
        guard let confirmPasswordStr = confirmPasswordTextField.text?.trimString(), !confirmPasswordStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: LoginConstant.enterConfirmPassword, message: nil)
            return
        }
        guard confirmPasswordStr.isValidPassword else {
            AppAlert.shared.simpleAlert(view: self, title: LoginConstant.passwordlength, message: nil)
            return
        }
        guard newPasswordStr == confirmPasswordStr else {
            AppAlert.shared.simpleAlert(view: self, title: LoginConstant.passwordSame, message: nil)
            return
        }
        
        var parameter: Parameters
        if isFromForgotPassword {
            parameter = [LoginConstant.account_type : self.accountType.rawValue,
                         LoginConstant.username : self.emailOrPhone,
                         LoginConstant.otp : self.otpString,
                         LoginConstant.salt_key : APPConstant.salt_key,
                         LoginConstant.password : newPasswordStr,
                         LoginConstant.password_confirmation : confirmPasswordStr]
            if accountType == .mobile {
                parameter[LoginConstant.country_code] = countryCode
            }
            self.myAccountPresenter?.resetPassword(param: parameter)
        }else{
            parameter = [LoginConstant.old_password : oldPasswordStr!,
                         LoginConstant.password : newPasswordStr,
                         LoginConstant.password_confirmation : confirmPasswordStr]
            self.myAccountPresenter?.changePassword(param: parameter)
        }
        
    }
    
    @objc func tapShowPassword(_ sender:UIButton) {
        if sender.tag == 0 {
            isHideOldPassword = !isHideOldPassword
        }else if sender.tag == 1 {
            isHideNewPassword = !isHideNewPassword
        }else{
            isHideConfirmPassword = !isHideConfirmPassword
        }
    }
    
    
    @objc func tapNext() {
        print("OTP \(otpString)")
        if (otpString.count > 0)  && (otpString == otpTextField.text) {
            self.isShowOtp = false
            setTitle()
        }else{
//            AppAlert.shared.simpleAlert(view: self, title: String.empty, message: (otpTextField.text?.isEmpty ?? false) ? AccountConstant.enterOtp : AccountConstant.invalidOtp)
            ToastManager.show(title: (otpTextField.text?.isEmpty ?? false) ? AccountConstant.enterOtp : AccountConstant.invalidOtp, state: .error)
        }
    }
    
    private func setFont() {
        otpTextField.font = UIFont.setCustomFont(name: .medium, size: .x16)
        confirmPasswordTextField.font = UIFont.setCustomFont(name: .medium, size: .x16)
        self.saveButton.titleLabel?.font = .setCustomFont(name: .medium, size: .x16)

        newPasswordTextField.font = UIFont.setCustomFont(name: .medium, size: .x16)
        oldPasswordTextField.font = UIFont.setCustomFont(name: .medium, size: .x16)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing()
    }
}

//Textfield Delegate
extension ChangePasswordController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        if textField == self.otpTextField && (textField.text?.count ?? 0) > 6 && !string.isEmpty  {
            return false
            
        }
        return true
    }
}

//MARK:- Account VIPER protocvols
extension ChangePasswordController:AccountPresenterToAccountViewProtocol {
    func resetPassword(resetPasswordEntity: ResetPasswordEntity) {
        AppAlert.shared.simpleAlert(view: self, title: Constant.passwordChangesMsg, message: String.empty, buttonTitle: Constant.SOk.localized)
        AppAlert.shared.onTapAction = { [weak self] tag in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                let vc = LoginRouter.loginStoryboard.instantiateViewController(withIdentifier: LoginConstant.SignInController)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    
    func changePasswordSuccess(changePassword: SuccessEntity) {
        AppAlert.shared.simpleAlert(view: self, title: Constant.passwordChangesMsg, message: String.empty, buttonTitle: Constant.SOk.localized)
        AppAlert.shared.onTapAction = { tag in
            DispatchQueue.main.async {
                BackGroundRequestManager.share.stopBackGroundRequest()
                       BackGroundRequestManager.share.resetBackGroudTask()
                       AppConfigurationManager.shared.baseConfigModel = nil
                       
                              PersistentManager.shared.delete(entityName: CoreDataEntity.loginData.rawValue)
                              PersistentManager.shared.delete(entityName: CoreDataEntity.userData.rawValue)
                BackGroundRequestManager.share.stopBackGroundRequest()

                let walkThrough = LoginRouter.loginStoryboard.instantiateViewController(withIdentifier: LoginConstant.SplashViewController)
                CommonFunction.changeRootController(controller: walkThrough)
            }
            
        }
    }
    
}
