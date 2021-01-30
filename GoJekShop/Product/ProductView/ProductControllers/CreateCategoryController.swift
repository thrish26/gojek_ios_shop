//
//  CreateCategoryController.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Alamofire
class CreateCategoryController: UIViewController {
    
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var desTextField: CustomTextField!
    @IBOutlet weak var statusTextField: CustomTextField!
    @IBOutlet weak var imageOverView: UIView!
    @IBOutlet weak var imageUploadLabel: UILabel!
    @IBOutlet weak var uploadImageLabel: UILabel!
    @IBOutlet weak var uploadImageDesLabel: UILabel!
    @IBOutlet weak var uploadImageButton: UIButton!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var overSubView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var uploadImageImageview: UIImageView!
    
    
    var statusArr = [AccountConstant.disable, AccountConstant.enable]
    var categoryData: CategoryData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initalLoads()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        saveButton.setCornerRadius()
        imageOverView.setCornerRadiuswithValue(value: 8)
        uploadImageImageview.setCornerRadiuswithValue(value: 8)
        overSubView.setCornerRadiuswithValue(value: 12)
    }
    
    private func initalLoads(){
        overView.backgroundColor = .backgroundColor
        overSubView.backgroundColor = .boxColor
        self.view.backgroundColor = .backgroundColor
        setFont()
        imageOverView.backgroundColor = .backgroundColor
        uploadImageImageview.backgroundColor = .black
        saveButton.setTitle(Constant.SSave.localized, for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .appPrimaryColor
        saveButton.titleLabel?.font = .setCustomFont(name: .bold, size: .x14)
        saveButton.addTarget(self, action: #selector(TapOnSaveAction), for: .touchUpInside)
        uploadImageDesLabel.textColor = .lightGray
        initalTitle()
        self.title = ProductConstant.createCategory
        uploadImageButton.addTarget(self, action: #selector(tapImage), for: .touchUpInside)
        self.setLeftBarButtonWith(color: .blackColor)
        setNavigationTitle()
        nameTextField.delegate = self
        desTextField.delegate = self
        statusTextField.delegate = self
        if categoryData != nil {
            nameTextField.text = categoryData?.store_category_name
            desTextField.text = categoryData?.store_category_description
            if categoryData?.store_category_status == 1 {
                statusTextField.text = AccountConstant.enable
            }else{
                statusTextField.text = AccountConstant.disable
            }
            if let categoryImageUrl = URL(string: categoryData?.picture ?? ""){
                uploadImageImageview.sd_setImage(with: categoryImageUrl, placeholderImage: UIImage(named: ProductConstant.ic_Product_upload))
                
            }else{
                uploadImageImageview.image = UIImage(named: ProductConstant.ic_Product_upload)
            }
            
        }else{
            uploadImageImageview.image = UIImage(named: ProductConstant.ic_Product_upload)
            
        }
    }
    
    private func initalTitle(){
        imageUploadLabel.text = ProductConstant.imageUpload.localized
        uploadImageLabel.text = ProductConstant.uploadImage.localized
        uploadImageDesLabel.text = ProductConstant.imageFormat.localized
        nameTextField.placeholder = Constant.SName.localized
        
        desTextField.placeholder = ProductConstant.description.localized
        statusTextField.placeholder = ProductConstant.status.localized
    }
    
    @objc func TapOnSaveAction() {
        if validation() {

                if categoryData == nil {
                    createCatgeory()
                    
                }else{
                    updateCatgeory()
                }
            
        }
    }
    
    private func updateCatgeory(){
        var parameter: Parameters = [
            ProductConstant.PStore_category_name:nameTextField.text ?? "",
            ProductConstant.PStore_category_description:desTextField.text ?? "",
            ProductConstant.Pmethod:ProductConstant.PPatch]
        
        if statusTextField.text == AccountConstant.enable {
            parameter[ProductConstant.PStore_category_status] = 1
        }else {
            parameter[ProductConstant.PStore_category_status] = 0
        }
        
        var categoryImageData: Data!

            if  let categoryData = uploadImageImageview.image?.jpegData(compressionQuality: 0.5) {
                categoryImageData = categoryData
            }
            if categoryImageData != nil {
                productPresenter?.updateCategory(param: parameter, imageData: [ProductConstant.PPicture:categoryImageData], categoryId: categoryData?.id ?? 0)
            }
    }
    
    private func setFont(){
        nameTextField.font = .setCustomFont(name: .medium, size: .x14)
        desTextField.font = .setCustomFont(name: .medium, size: .x14)
        statusTextField.font = .setCustomFont(name: .medium, size: .x14)
        imageUploadLabel.font = .setCustomFont(name: .medium, size: .x14)
        uploadImageLabel.font = .setCustomFont(name: .medium, size: .x14)
        uploadImageDesLabel.font = .setCustomFont(name: .medium, size: .x14)
        saveButton.titleLabel?.font = .setCustomFont(name: .medium, size: .x14)
    }
    
    private func validation() -> Bool {
        guard let nameStr = nameTextField.text?.trimString(), !nameStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: ProductConstant.nameEmpty.localized, message: nil)
            return false
        }
        guard let descriptionStr = desTextField.text?.trimString(), !descriptionStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: ProductConstant.descriptionEmpty.localized, message: nil)
            return false
        }
        guard let statusStr = statusTextField.text?.trimString(), !statusStr.isEmpty else {
                  AppAlert.shared.simpleAlert(view: self, title: ProductConstant.statusEmpty.localized, message: nil)
                  return false
              }
        if uploadImageImageview.image == UIImage(named: ProductConstant.ic_Product_upload) {
            AppAlert.shared.simpleAlert(view: self, title: ProductConstant.categoryImageEmpty.localized, message: nil)
                           return false
        }
        return true
    }
    
    @objc func tapImage() {
        self.showImage(isRemoveNeed: nil, with:{ (image) in
            self.uploadImageImageview.image = image
        })
        
    }
    
    private func createCatgeory(){
        var parameter: Parameters = [
            ProductConstant.PStore_category_name:nameTextField.text ?? "",
            ProductConstant.PStore_category_description:desTextField.text ?? "",
            ProductConstant.PStoreId: String(AppManager.shared.storeId ?? 0)
        ]
        for status in statusArr {
            if status == AccountConstant.enable {
                parameter[ProductConstant.PStore_category_status] = 1
            }else{
                parameter[ProductConstant.PStore_category_status] = 0
            }
        }
        var categoryImageData: Data!
        if  let categoryData = uploadImageImageview.image?.jpegData(compressionQuality: 0.5) {
            categoryImageData = categoryData
        }
        if categoryImageData != nil {
            productPresenter?.addCategory(param: parameter, imageData: [ProductConstant.PPicture:categoryImageData])
        }
    }
}

//MARK:- UITextFieldDelegate

extension CreateCategoryController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case statusTextField:
            PickerManager.shared.showPicker(pickerData: statusArr, selectedData: nil) { [weak self] (selectedType) in
                guard let self = self else {
                    return
                }
                self.statusTextField.text = selectedType
                self.view.setNeedsUpdateConstraints()
                self.view.layoutIfNeeded()
            }
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
}

//MARK:- ProductPresenterToProductViewProtocol

extension CreateCategoryController: ProductPresenterToProductViewProtocol {
    
    func createCategorySuccess(createCategoryEntity: CreateAddonsEntity) {
        ToastManager.show(title: createCategoryEntity.message ?? "", state: .success)
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateCategorySuccess(updateCategoryEntity: CreateAddonsEntity) {
        ToastManager.show(title: updateCategoryEntity.message ?? "", state: .success)
        self.navigationController?.popViewController(animated: true)
    }
}
