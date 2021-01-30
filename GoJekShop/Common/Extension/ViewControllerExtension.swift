//
//  ViewControllerExtension.swift
//  GoJekUser
//
//  Created by Ansar on 25/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import UIKit
import AVKit

private var imageCompletion : ((UIImage?)->())?

extension UIViewController {
    
    //MARK:- Show Image Selection Action Sheet
    
    func showImage(isRemoveNeed: String? = nil,with completion : @escaping ((UIImage?)->())){  //isRemoveNeed - used to remove photo in profile
        
        AppActionSheet.shared.showActionSheet(viewController: self,message: Constant.choosePicture.localized, buttonOne: Constant.SopenCamera.localized, buttonTwo: Constant.SopenGalley.localized,buttonThird: isRemoveNeed == nil ? nil : Constant.removePhoto.localized)
        imageCompletion = completion
        AppActionSheet.shared.onTapAction = { [weak self] tag in
            guard let self = self else {
                return
            }
            if tag == 0 {
                self.checkCameraPermission(source: .camera)
            }else if tag == 1 {
                self.checkCameraPermission(source: .photoLibrary)
            }else {
                let imageView = UIImageView()
                imageView.image = UIImage(named: Constant.userPlaceholderImage)
                imageCompletion?(imageView.image)
            }
        }
    }
    
    private func checkCameraPermission(source : UIImagePickerController.SourceType) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch (cameraAuthorizationStatus){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.chooseImage(with: source)
                    }else {
                        ToastManager.show(title: Constant.cameraPermission.localized, state: .warning)
                    }
                }
            }
        case .restricted, .denied:
            ToastManager.show(title: Constant.cameraPermission.localized, state: .warning)
        case .authorized:
            self.chooseImage(with: source)
        default:
            ToastManager.show(title: Constant.cameraPermission.localized, state: .warning)
        }
    }
    
    // MARK:- Show Image Picker
    
    private func chooseImage(with source : UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = source
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    // MARK: - Hide KeyBoard
    func hideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func hideTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    public func showTabBar() {
        
        if let languageStr = UserDefaults.standard.value(forKey: AccountConstant.language) as? String, let language = Language(rawValue: languageStr) {
            LocalizeManager.share.setLocalization(language: language)
        }
        else {
            LocalizeManager.share.setLocalization(language: .english)
        }
        self.tabBarController?.tabBar.isHidden = false
        guard let items = self.tabBarController?.tabBar.items else { return }
        
        
        items[0].title = HomeConstant.THome.localized
        items[1].title = OrderConstant.orders.localized
        items[2].title = ProductConstant.TProduct.localized
        items[3].title = NotificationConstant.TNotification.localized
        items[4].title = AccountConstant.account.localized
        
        if CommonFunction.checkisRTL() {
            
            self.tabBarController?.tabBar.semanticContentAttribute = .forceRightToLeft
            
        }else {
            self.tabBarController?.tabBar.semanticContentAttribute = .forceLeftToRight
            
        }
        
    }
    
    public func setNavigationTitle() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blackColor, NSAttributedString.Key.font: UIFont.setCustomFont(name: .bold, size: .x20)]
    }
    
    //Left navigation button
    func setLeftBarButtonWith(color leftButtonImageColor: UIColor, leftButtonImage: String?=nil) {
        if CommonFunction.checkisRTL() {
            let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: Constant.ic_back)?.imageFlippedForRightToLeftLayoutDirection(), style: .plain, target: self, action: #selector(leftBarButtonAction))
            self.navigationController?.navigationBar.tintColor = leftButtonImageColor
            self.navigationItem.leftBarButtonItem = leftBarButton
        }else {
            let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: Constant.ic_back), style: .plain, target: self, action: #selector(leftBarButtonAction))
            self.navigationController?.navigationBar.tintColor = leftButtonImageColor
            self.navigationItem.leftBarButtonItem = leftBarButton
        }
    }
    
    //Left navigation bar button action
    @objc func leftBarButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK:- UIImagePickerControllerDelegate

extension UIViewController: UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                imageCompletion?(image)
            }
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

//MARK:- UINavigationControllerDelegate

extension UIViewController: UINavigationControllerDelegate {
    
}
