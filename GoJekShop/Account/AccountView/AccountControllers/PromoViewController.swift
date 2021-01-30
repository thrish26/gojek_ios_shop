//
//  PromoViewController.swift
//  GoJekShop
//
//  Created by JeyaPrakash on 06/11/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Alamofire

class PromoViewController: UIViewController {

    @IBOutlet weak var promoStackView: UIStackView!
    @IBOutlet weak var userLimitTextField: CustomTextField!
        @IBOutlet weak var nameTextField: CustomTextField!
        @IBOutlet weak var percentageTextField: CustomTextField!
        @IBOutlet weak var minTextField: CustomTextField!
        @IBOutlet weak var maxTextField: CustomTextField!
        @IBOutlet weak var imageUploadLabel: UILabel!
        @IBOutlet weak var imageUploadButton: UIButton!
        @IBOutlet weak var uploadImageLabel: UILabel!
        @IBOutlet weak var imageFormatLabel: UILabel!
        @IBOutlet weak var descriptionTextField: CustomTextField!
        @IBOutlet weak var expirationTextField: CustomTextField!
        @IBOutlet weak var scrollView: UIScrollView!
        @IBOutlet weak var imageOverView: UIView!
        @IBOutlet weak var productImageview: UIImageView!
    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var overSubView: UIView!
    @IBOutlet weak var imageoutterView: UIView!
    

        
        var statusArr = [AccountConstant.disable, AccountConstant.enable]
        var discountTypeArr = ["PERCENTAGE","AMOUNT"]
        var unitArr:[UnitResponseData] = []
        var offSet: Int = 0
        var isUpdate = false
        var totalRecord = 0
        var categoryData :CategoryData?
        var productData :PromoCodeData?
        var addonsList:[AddonsListResponseData] = []
        var priceArr:NSMutableArray = []
        var IdArr:NSMutableArray = []
        let addonsName:NSMutableArray = []
        var isEdit = false
        var productImageData: Data!
        var category_id = 0
        var unit_id = 0
        var promoCodeId = 0
        var temppercent = "0%"
        var tempmaxamount = "is 0"
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
            initalLoads()
        }

        override func viewWillAppear(_ animated: Bool) {
            if isEdit{
                accountPresenter?.getPromoDetails(id: "\(productData?.id ?? 0)")
                saveButton.setTitle(Constant.SSave.localized, for: .normal)
            }
            else{
                saveButton.setTitle(Constant.SAdd.localized, for: .normal)
                descriptionTextField.text = Constant.tempPromoDescription.localized
            }
        }

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            saveButton.setCornerRadius()
            imageoutterView.setCornerRadiuswithValue(value: 8)
            productImageview.setCornerRadiuswithValue(value: 8)
            imageOverView.setCornerRadiuswithValue(value: 10)
        }
    
    
    
     }

extension PromoViewController {

        private func initalLoads(){
            setFont()
            setInitalTitle()
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.saveView.frame.height + 10, right: 0)
            saveButton.setTitle(Constant.SSave.localized, for: .normal)
            saveButton.titleLabel?.font = .setCustomFont(name: .bold, size: .x14)
            hideTabBar()
            self.title = ProductConstant.createPromo.localized
            imageUploadButton.addTarget(self, action: #selector(tapImage), for: .touchUpInside)
            setDelegate()
            setColor()
            productImageview.image = UIImage(named: ProductConstant.ic_Product_upload)
            saveButton.addTarget(self, action: #selector(TapOnSaveAction), for: .touchUpInside)
            maxTextField.tag = 1
            percentageTextField.tag = 2
            maxTextField.addTarget(self, action: #selector(textTyping(sender:)), for: .editingChanged)
            percentageTextField.addTarget(self, action: #selector(textTyping(sender:)), for: .editingChanged)
            promoCodeId = productData?.id ?? 0

        }
    
    
    
    func setInitialData(){
        nameTextField.text = productData?.promo_code ?? ""
        minTextField.text = "\(productData?.min_amount ?? 0)"
        maxTextField.text = "\(productData?.max_amount ?? 0)"
        descriptionTextField.text = productData?.promo_description ?? ""
        expirationTextField.text = "\(productData?.expiration ?? "")"
        userLimitTextField.text = productData?.promo_code ?? ""
        percentageTextField.text = "\(productData?.percentage ?? 0)"
//        if(productData?.eligibility ?? 0 == 0){
//        eligiblitySwitch.setOn(false, animated: true)
//        }
//        else{
//        eligiblitySwitch.setOn(true, animated: true)
//        }
        if let productImageUrl = URL(string: productData?.picture ?? ""){
            productImageview.sd_setImage(with: productImageUrl, placeholderImage: UIImage(named: ProductConstant.dummy))
            
        }else{
            productImageview.image = UIImage(named: ProductConstant.dummy)
        }
    }
    
    
    @objc func TapOnSaveAction() {

        if validation() {
            if  let productData = productImageview.image?.jpegData(compressionQuality: 0.5) {
                      productImageData = productData
            }
            if productImageData == nil {
                AppAlert.shared.simpleAlert(view: self, title: ProductConstant.promoImageEmpty.localized, message: nil)
                
            }else{
                if isEdit {
                    editPromoApi()
                }else{
                    createUpdatePromoApi()

                }
            }
        }
    }
    
    private func editPromoApi(){
         var parameter: Parameters = [
             ProductConstant.Ppromo_code:nameTextField.text ?? "",
             ProductConstant.P_method: "PATCH",
             ProductConstant.Pservice: "ORDER",
             ProductConstant.Peligibility: 1,
             ProductConstant.Ppercentage: percentageTextField.text ?? "",
             ProductConstant.Pmin_amount: minTextField.text ?? "",
             ProductConstant.Pmax_amount: maxTextField.text ?? "",
             ProductConstant.Ppromo_description: descriptionTextField.text ?? "",
             ProductConstant.Pexpiration: expirationTextField.text ?? "",
             ProductConstant.Puser_limit: userLimitTextField.text ?? ""
         ]
        if productImageData != nil {
            accountPresenter?.editPromo(param: parameter, id: "\(promoCodeId)", imageData: [ProductConstant.PPicture:productImageData])
        }
    }
    
    private func createUpdatePromoApi(){
         var parameter: Parameters = [
             ProductConstant.Ppromo_code:nameTextField.text ?? "",
             ProductConstant.Pservice: "ORDER",
             ProductConstant.Peligibility: 1,
             ProductConstant.Ppercentage: percentageTextField.text ?? "",
             ProductConstant.Pmin_amount: minTextField.text ?? "",
             ProductConstant.Pmax_amount: maxTextField.text ?? "",
             ProductConstant.Ppromo_description: descriptionTextField.text ?? "",
             ProductConstant.Pexpiration: expirationTextField.text ?? "",
             ProductConstant.Puser_limit: userLimitTextField.text ?? ""
         ]
        if productImageData != nil {
            accountPresenter?.addPromo(param: parameter, imageData: [ProductConstant.PPicture:productImageData])
        }
    }

      private func validation() -> Bool {
          guard let nameStr = nameTextField.text?.trimString(), !nameStr.isEmpty else {
              AppAlert.shared.simpleAlert(view: self, title: ProductConstant.promoEmpty.localized, message: nil)
              return false
          }
          guard let userLimitStr = userLimitTextField.text?.trimString(), !userLimitStr.isEmpty else {
              AppAlert.shared.simpleAlert(view: self, title: ProductConstant.userLimitEmpty.localized, message: nil)
              return false
          }
          guard let descriptionStr = descriptionTextField.text?.trimString(), !descriptionStr.isEmpty else {
              AppAlert.shared.simpleAlert(view: self, title: ProductConstant.descriptionEmpty.localized, message: nil)
              return false
          }
          
          guard let minStr = minTextField.text?.trimString(), !minStr.isEmpty else {
              AppAlert.shared.simpleAlert(view: self, title: ProductConstant.minEmpty.localized, message: nil)
              return false
          }
        
         guard let maxStr = maxTextField.text?.trimString(), !maxStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: ProductConstant.maxEmpty.localized, message: nil)
            return false
        }
        
         guard let expirationStr = expirationTextField.text?.trimString(), !expirationStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: ProductConstant.expirationEmpty.localized, message: nil)
            return false
        }
        
         guard let percentageStr = percentageTextField.text?.trimString(), !percentageStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: ProductConstant.percentageEmpty.localized, message: nil)
            return false
        }
        
        
        
          if productImageview.image == UIImage(named: ProductConstant.ic_Product_upload) {
              AppAlert.shared.simpleAlert(view: self, title: ProductConstant.promoImageEmpty.localized, message: nil)
              return false
          }
        return true
      }
        private func setColor(){
            setNavigationTitle()
            saveView.backgroundColor = .backgroundColor
            self.view.backgroundColor = .backgroundColor
            overView.backgroundColor = .backgroundColor
            overSubView.backgroundColor = .boxColor
            promoStackView.backgroundColor = .boxColor
            imageOverView.backgroundColor = .backgroundColor
            imageoutterView.backgroundColor = .backgroundColor
            imageFormatLabel.textColor = .lightGray
            saveButton.backgroundColor = .appPrimaryColor
            saveButton.setTitleColor(.white, for: .normal)
            self.setLeftBarButtonWith(color: .blackColor)
        }

        private func setDelegate(){
            expirationTextField.delegate = self
//            desTextField.delegate = self
//            statusTextField.delegate = self
//            categoryTextField.delegate = self
//            priceTextField.delegate = self
//            discountTypeTextField.delegate = self
//            discountTextField.delegate = self
//            qtyTextField.delegate  = self
//            unitTextField.delegate = self
//            discountTextField.keyboardType = .numberPad
//            qtyTextField.keyboardType = .numberPad
        }

        private func setInitalTitle(){
            saveButton.setTitle(Constant.SSave.localized, for: .normal)
            userLimitTextField.placeholder = ProductConstant.userLimit.localized
            expirationTextField.placeholder = ProductConstant.expiration.localized
            descriptionTextField.placeholder = ProductConstant.description.localized
            percentageTextField.placeholder = ProductConstant.percentage.localized
            nameTextField.placeholder = Constant.promoCode.localized
            minTextField.placeholder = ProductConstant.minAmount.localized
            imageUploadLabel.text = ProductConstant.imageUpload.localized
            uploadImageLabel.text = ProductConstant.uploadImage.localized
            imageFormatLabel.text = ProductConstant.imageFormat.localized
            maxTextField.placeholder = ProductConstant.maxAmount.localized
        }
    

       @objc func textTyping(sender : UITextField){

       }

        private func setFont(){
            nameTextField.font = .setCustomFont(name: .medium, size: .x14)
            userLimitTextField.font = .setCustomFont(name: .medium, size: .x14)
            expirationTextField.font = .setCustomFont(name: .medium, size: .x14)
            descriptionTextField.font = .setCustomFont(name: .medium, size: .x14)
            percentageTextField.font = .setCustomFont(name: .medium, size: .x14)
            nameTextField.font = .setCustomFont(name: .medium, size: .x14)
            maxTextField.font = .setCustomFont(name: .medium, size: .x14)
            saveButton.titleLabel?.font = .setCustomFont(name: .bold, size: .x14)
            imageUploadLabel.font = .setCustomFont(name: .medium, size: .x14)
            uploadImageLabel.font = .setCustomFont(name: .medium, size: .x14)
            imageFormatLabel.font = .setCustomFont(name: .medium, size: .x12)

        }


        @objc func tapImage() {
            self.showImage(isRemoveNeed: nil, with:{ (image) in
                self.productImageview.image = image
                self.productImageview.image = self.productImageview.image?.convert(toSize:CGSize(width:300.0, height:200.0), scale: image?.scale ?? CGFloat())
            })
        }


}


extension PromoViewController : AccountPresenterToAccountViewProtocol {
    
    func createPromoSuccess(createProductEntity: CreateProductEntity) {
        ToastManager.show(title: ProductConstant.promoAddSuccess, state: .success)
        self.navigationController?.popViewController(animated: true)
    }
    
    func getPromoDetails(editProductEntity: CreatePromoEntity) {
        productData = editProductEntity.responseData
        setInitialData()
    }
    
    func editPromoSuccess(editProductEntity: CreateProductEntity) {
        ToastManager.show(title: ProductConstant.promoEditSuccess, state: .success)
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension PromoViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
           self.view.endEditing()
           switch textField {
           case expirationTextField:
                PickerManager.shared.showDatePicker(selectedDate: nil) { (data) in
                   let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "dd-MM-yyyy"
                   let date = dateFormatter.date(from: data)
                   dateFormatter.dateFormat = "MM/dd/yyyy"
                    self.expirationTextField.text = dateFormatter.string(from: date!)
               }
               return false
           default:
           return true
          }
        }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing()
           return true
       }
}
