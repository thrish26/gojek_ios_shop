//
//  EditRestaurantController.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Alamofire
import GooglePlaces
import CoreLocation

class EditRestaurantController: UIViewController {
    
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var statusTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var mobileTextField: CustomTextField!
    @IBOutlet weak var landMarkTextField: CustomTextField!
    @IBOutlet weak var cityTextField: CustomTextField!
    @IBOutlet weak var countryTextField: CustomTextField!
    @IBOutlet weak var deliveryTimeTextField: CustomTextField!
    @IBOutlet weak var minAmtField: CustomTextField!
    @IBOutlet weak var offerPercentTextField: CustomTextField!
    @IBOutlet weak var descriptionTextField: CustomTextField!
    @IBOutlet weak var countryCodeTextField: CustomTextField!
    @IBOutlet weak var cusineLabel: InsetLabel!
    @IBOutlet weak var cusineTitleLabel: UILabel!
    @IBOutlet weak var zoneTextField: CustomTextField!
    @IBOutlet weak var zipCodeTextField: CustomTextField!
    @IBOutlet weak var contactPersonTextField: CustomTextField!
    @IBOutlet weak var comissionTextField: CustomTextField!
    @IBOutlet weak var gstTaxTextField: CustomTextField!
    @IBOutlet weak var storePackageChargeTextField: CustomTextField!
    
    @IBOutlet weak var flatNoTextField: CustomTextField!
    @IBOutlet weak var streetTextField: CustomTextField!
    @IBOutlet weak var shopResponseTimeTextField: CustomTextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageOverView: UIView!
    @IBOutlet weak var imageUploadLabel: UILabel!
    @IBOutlet weak var uploadImageLabel: UILabel!
    @IBOutlet weak var uploadImageDesLabel: UILabel!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var uploadImageButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var pureVegLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var heightConstaint: NSLayoutConstraint?
    @IBOutlet weak var cusineBgVw: UIView!
    @IBOutlet weak var purevegBgVw: UIView!
    
    @IBOutlet weak var freeDeliveryBGVw: UIView!
    @IBOutlet weak var freeDeliveryLbl: UILabel!
    @IBOutlet weak var freeDeliverySwitch: UISwitch!
    @IBOutlet weak var freeDeliveryMinimumAmtTxtFld: CustomTextField!
    @IBOutlet weak var bestSellerCountTxtFld: CustomTextField!
    @IBOutlet weak var bestSellerMonthTxtFld: CustomTextField!
    
    
    var statusArr = [AccountConstant.disable, AccountConstant.enable]
    var zoneArr = [String]()
    var countryData: [CountryData] = []
    var cityDataArr: [City_data] = []
    var selectedCuisineData:[Cuisine_data] = []
    
    //Set country code and image
    private var countryDetail: Country? {
        didSet {
            if countryDetail != nil {
                countryCodeTextField.text = "   \(countryDetail?.dial_code ?? "")"
                countryCodeTextField.setFlag(imageStr: "CountryPicker.bundle/"+(countryDetail?.code ?? "US"))
            }
        }
    }
    
    private var isVeg:Bool = false {
        didSet {
            yesButton.setImage(UIImage(named: isVeg ? Constant.circleFullImage : Constant.circleImage), for: .normal)
            noButton.setImage(UIImage(named: isVeg ? Constant.circleImage : Constant.circleFullImage), for: .normal)
        }
    }
    
    var editRestaurant: EditRestaurantEntity?
    var selectedCityId: Int = 0
    var selectedZoneId: Int = 0
    var longitude: Double = 0
    var latitude: Double = 0
    var isImageEdit = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initalLoads()
    }
    
    private func initalLoads(){
        setFont()
        setTitle()
        hideTabBar()
        setTextFieldDelegate()
        freeDeliverySwitch.addTarget(self, action: #selector(tapFreeDeliverySwitch), for: .touchUpInside)
        freeDeliveryMinimumAmtTxtFld.isHidden = true
        bestSellerMonthTxtFld.text = "1"
        bestSellerCountTxtFld.text = "1"

        self.accountPresenter?.getEditRestaurant()
        saveButton.addTarget(self, action: #selector(tapSaveButton), for: .touchUpInside)
        uploadImageButton.addTarget(self, action: #selector(tapUploadImageButton), for: .touchUpInside)
        saveButton.backgroundColor = .appPrimaryColor
        saveButton.setTitleColor(.white, for: .normal)
        DispatchQueue.main.async {
            self.saveButton.setBothCorner()
        }
        comissionTextField.isUserInteractionEnabled = false
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.bottomView.frame.height + 10, right: 0)
        
        yesButton.tintColor = .black
        noButton.tintColor = .black
        
        let cusineLabelGest = UITapGestureRecognizer(target: self, action: #selector(tapCuisineData))
        cusineLabel.addGestureRecognizer(cusineLabelGest)
        cusineLabel.isUserInteractionEnabled = true
        
        yesButton.addTarget(self, action: #selector(tapIsVeg(_:)), for: .touchUpInside)
        noButton.addTarget(self, action: #selector(tapIsVeg(_:)), for: .touchUpInside)
        yesButton.setImage(UIImage(named: Constant.circleImage), for: .normal)
        yesButton.setImageTitle(spacing: 10)
        noButton.setImage(UIImage(named: Constant.circleImage), for: .normal)
        noButton.setImageTitle(spacing: 10)
        keyboardType()
        imageOverView.backgroundColor = .boxColor
        imageOverView.setCornerRadiuswithValue(value: 10)
        uploadImageView.image = UIImage(named: ProductConstant.ic_Product_upload)
        self.title = AppManager.shared.storeType == "OTHERS" ? AccountConstant.editShop.localized : AccountConstant.editRestaurant.localized
        setLeftBarButtonWith(color: .blackColor)
        setNavigationTitle()
        uploadImageDesLabel.textColor = .lightGray
        uploadImageView.backgroundColor = .boxColor
        countryTextField.isUserInteractionEnabled = false
        uploadImageView.setCornerRadiuswithValue(value: 10)
        cusineLabel.setCornerRadius()
        cusineLabel.layer.borderColor = UIColor.black.cgColor
        cusineLabel.layer.borderWidth = 1
        checkShopType()
    }
    
    
    @objc func tapCuisineData() {
        let cuisineViewController = self.storyboard?.instantiateViewController(withIdentifier: AccountConstant.TCuisineTableViewController) as! CuisineTableViewController
        cuisineViewController.delegate = self
        cuisineViewController.cuisineData = self.editRestaurant?.responseData?.cuisine_data ?? []
        cuisineViewController.selectedCuisineData = self.selectedCuisineData
        self.navigationController?.pushViewController(cuisineViewController, animated: true)
    }
    
    private  func keyboardType(){
        emailTextField.keyboardType = .emailAddress
        mobileTextField.keyboardType = .phonePad
        deliveryTimeTextField.keyboardType = .numberPad
        minAmtField.keyboardType = .numberPad
        offerPercentTextField.keyboardType = .numberPad
        zipCodeTextField.keyboardType = .numberPad
        comissionTextField.keyboardType = .numberPad
        gstTaxTextField.keyboardType = .numberPad
        storePackageChargeTextField.keyboardType = .numberPad
        shopResponseTimeTextField.keyboardType = .numberPad
        
    }
    
    private func setTextFieldDelegate(){
        
        nameTextField.delegate = self
        statusTextField.delegate = self
        emailTextField.delegate = self
        mobileTextField.delegate = self
        landMarkTextField.delegate = self
        cityTextField.delegate = self
        countryTextField.delegate = self
        deliveryTimeTextField.delegate = self
        minAmtField.delegate = self
        offerPercentTextField.delegate = self
        descriptionTextField.delegate = self
        countryCodeTextField.delegate = self
        zoneTextField.delegate = self
        zipCodeTextField.delegate = self
        contactPersonTextField.delegate = self
        comissionTextField.delegate = self
        gstTaxTextField.delegate = self
        storePackageChargeTextField.delegate = self
        freeDeliveryMinimumAmtTxtFld.delegate = self
        bestSellerMonthTxtFld.delegate = self
        bestSellerCountTxtFld.delegate = self
    }
    
    private func setTitle(){
        contactPersonTextField.placeholder = AccountConstant.contactPerson.localized
        nameTextField.placeholder = AccountConstant.name.localized
        statusTextField.placeholder = ProductConstant.status.localized
        emailTextField.placeholder = LoginConstant.email.localized
        mobileTextField.placeholder = AccountConstant.phoneNumber.localized
        landMarkTextField.placeholder = AccountConstant.location.localized
        cityTextField.placeholder = AccountConstant.city.localized
        countryTextField.placeholder = AccountConstant.Country.localized
        deliveryTimeTextField.placeholder = AccountConstant.MaximumDeliveryTime.localized
        minAmtField.placeholder = AccountConstant.minAmt.localized
        offerPercentTextField.placeholder = AccountConstant.offerInPercentage.localized
        descriptionTextField.placeholder = ProductConstant.description.localized
        countryCodeTextField.placeholder = AccountConstant.code.localized
        cusineTitleLabel.text = AccountConstant.cuisine.localized
        saveButton.setTitle(Constant.SSave.localized, for: .normal)
        imageUploadLabel.text = ProductConstant.imageUpload.localized
        uploadImageLabel.text = ProductConstant.uploadImage.localized
        uploadImageDesLabel.text = ProductConstant.imageFormat.localized
        yesButton.setTitle(Constant.SYes.localized, for: .normal)
        noButton.setTitle(Constant.SNo.localized, for: .normal)
        zipCodeTextField.placeholder = AccountConstant.zipCode.localized
        zoneTextField.placeholder = AccountConstant.zone.localized
        pureVegLabel.text = AccountConstant.pureVegRestaurant.localized
        comissionTextField.placeholder = AccountConstant.commission.localized
        gstTaxTextField.placeholder = AccountConstant.gstPercent.localized
        storePackageChargeTextField.placeholder =
            AccountConstant.storePackageCharge.localized
        shopResponseTimeTextField.placeholder = AccountConstant.storeResponseTime.localized
        flatNoTextField.placeholder = AccountConstant.flatNo.localized
        streetTextField.placeholder = AccountConstant.street.localized
        freeDeliveryMinimumAmtTxtFld.placeholder = AccountConstant.minimumAmt.localized
        bestSellerCountTxtFld.placeholder = AccountConstant.bestsellercount.localized
        bestSellerMonthTxtFld.placeholder = AccountConstant.bestsellermonth.localized
    }
    
    private func setFont(){
        storePackageChargeTextField.font = .setCustomFont(name: .medium, size: .x14)
        comissionTextField.font = .setCustomFont(name: .medium, size: .x14)
        nameTextField.font = .setCustomFont(name: .medium, size: .x14)
        statusTextField.font = .setCustomFont(name: .medium, size: .x14)
        emailTextField.font = .setCustomFont(name: .medium, size: .x14)
        mobileTextField.font = .setCustomFont(name: .medium, size: .x14)
        landMarkTextField.font = .setCustomFont(name: .medium, size: .x14)
        cityTextField.font = .setCustomFont(name: .medium, size: .x14)
        countryTextField.font = .setCustomFont(name: .medium, size: .x14)
        deliveryTimeTextField.font = .setCustomFont(name: .medium, size: .x14)
        minAmtField.font = .setCustomFont(name: .medium, size: .x14)
        offerPercentTextField.font = .setCustomFont(name: .medium, size: .x14)
        descriptionTextField.font = .setCustomFont(name: .medium, size: .x14)
        countryCodeTextField.font = .setCustomFont(name: .medium, size: .x14)
        cusineLabel.font = .setCustomFont(name: .medium, size: .x14)
        imageUploadLabel.font = .setCustomFont(name: .medium, size: .x14)
        uploadImageLabel.font = .setCustomFont(name: .medium, size: .x14)
        uploadImageDesLabel.font = .setCustomFont(name: .medium, size: .x12)
        pureVegLabel.font = .setCustomFont(name: .medium, size: .x14)
        yesButton.titleLabel?.font = .setCustomFont(name: .medium, size: .x14)
        noButton.titleLabel?.font = .setCustomFont(name: .medium, size: .x14)
        zoneTextField?.font  = .setCustomFont(name: .medium, size: .x14)
        zipCodeTextField?.font = .setCustomFont(name: .medium, size: .x14)
        contactPersonTextField?.font = .setCustomFont(name: .medium, size: .x14)
        gstTaxTextField?.font = .setCustomFont(name: .medium, size: .x14)
        cusineTitleLabel.font = .setCustomFont(name: .medium, size: .x14)
        shopResponseTimeTextField.font = .setCustomFont(name: .medium, size: .x14)
        flatNoTextField.font = .setCustomFont(name: .medium, size: .x14)
        streetTextField.font = .setCustomFont(name: .medium, size: .x14)
        freeDeliveryMinimumAmtTxtFld.font = .setCustomFont(name: .medium, size: .x14)
        bestSellerCountTxtFld.font = .setCustomFont(name: .medium, size: .x14)
        bestSellerMonthTxtFld.font = .setCustomFont(name: .medium, size: .x14)
    }
    private func checkShopType(){
          if AppManager.shared.storeType == "OTHERS" {
              cusineTitleLabel.isHidden =  true
              cusineLabel.isHidden = true
              cusineBgVw.isHidden = true
              purevegBgVw.isHidden = true
              deliveryTimeTextField.isHidden = true
          }else{
              cusineTitleLabel.isHidden =  false
              cusineLabel.isHidden = false
               cusineBgVw.isHidden = false
              purevegBgVw.isHidden = false
              deliveryTimeTextField.isHidden = false
          }
      }
    private func validation() -> Bool {
        
        guard let nameStr = nameTextField.text?.trimString(), !nameStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: ProductConstant.nameEmpty.localized, message: nil)
            return false
        }
        
        guard let countryCodeStr = countryCodeTextField.text?.trimString(), !countryCodeStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.countryCodeEmpty.localized, message: nil)
            return false
        }
        
        guard let mobileStr = mobileTextField.text?.trimString(), !mobileStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.phoneEmpty.localized, message: nil)
            return false
        }
        
        guard let emailStr = emailTextField.text?.trimString(), !emailStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.emailEmpty.localized, message: nil)
            return false
        }
        
        guard let cityStr = cityTextField.text?.trimString(), !cityStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.cityEmpty.localized, message: nil)
            return false
        }
        
       if AppManager.shared.storeType == "OTHERS" {}else{
               guard let cusineStr = cusineLabel.text?.trimString(), !cusineStr.isEmpty else {
                   AppAlert.shared.simpleAlert(view: self, title: AccountConstant.cuisineEmpty.localized, message: nil)
                   return false
        }}
               
        guard let gstStr = gstTaxTextField.text?.trimString(), !gstStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.gstEmpty.localized, message: nil)
            return false
        }
        
        guard let contactPersonStr = contactPersonTextField.text?.trimString(), !contactPersonStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.contactPersonEmpty.localized, message: nil)
            return false
        }
        
        guard let statusStr = statusTextField.text?.trimString(), !statusStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.statusEmpty.localized, message: nil)
            return false
        }
        
        guard let minAmtStr = minAmtField.text?.trimString(), !minAmtStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.minAmountEmpty.localized, message: nil)
            return false
        }
        
        guard let offerPercentStr = offerPercentTextField.text?.trimString(), !offerPercentStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.offerPercentEmpty.localized, message: nil)
            return false
        }
        
        guard let commissionStr = comissionTextField.text?.trimString(), !commissionStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.commissionEmpty.localized, message: nil)
            return false
        }
        guard let bestSellerStr = bestSellerCountTxtFld.text?.trimString(), !bestSellerStr.isEmpty else {
                      AppAlert.shared.simpleAlert(view: self, title: AccountConstant.bestsellerError.localized, message: nil)
                      return false
                  }
        
           let countNum = Int(bestSellerStr) ?? 0
         if countNum >= 1  {
            
         }else{
            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.countError.localized, message: nil)
                        return false
        }
        guard let bestSellerMonthStr = bestSellerMonthTxtFld.text?.trimString(), !bestSellerMonthStr.isEmpty else {
                  AppAlert.shared.simpleAlert(view: self, title: AccountConstant.monthError.localized, message: nil)
                  return false
              }
        let monthNum = Int(bestSellerMonthStr) ?? 0
        if monthNum >= 1 && monthNum <= 12 {

        }else{
                AppAlert.shared.simpleAlert(view: self, title: AccountConstant.monthError.localized, message: nil)
             return false
        }
      
        
       if AppManager.shared.storeType == "OTHERS" {}else{
        guard let deliveryTimeStr = deliveryTimeTextField.text?.trimString(), !deliveryTimeStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.maximumDeliveryTimeEmpty.localized, message: nil)
            return false
            }}
        
        guard let descriptionStr = descriptionTextField.text?.trimString(), !descriptionStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.desEmpty.localized, message: nil)
            return false
        }
//        guard let flatStr = landMarkTextField.text?.trimString(), !landmarkStr.isEmpty else {
//                   AppAlert.shared.simpleAlert(view: self, title: AccountConstant.landmarkEmpty.localized, message: nil)
//                   return false
//               }
        
        guard let landmarkStr = landMarkTextField.text?.trimString(), !landmarkStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.location.localized, message: nil)
            return false
        }
        
//        guard let zoneStr = zoneTextField.text?.trimString(), !zoneStr.isEmpty else {
//            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.zoneEmpty.localized, message: nil)
//            return false
//        }
        guard let shopResponseTimeStr = shopResponseTimeTextField.text?.trimString(), !shopResponseTimeStr.isEmpty else {
                 AppAlert.shared.simpleAlert(view: self, title: AccountConstant.shopresponseEmpty.localized, message: nil)
                 return false
             }
        
        guard let zipCodeStr = zipCodeTextField.text?.trimString(), !zipCodeStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: AccountConstant.zipEmpty.localized, message: nil)
            return false
        }
        
        return true
    }
    
    @objc func tapSaveButton() {
        if validation()
        {
            createEditRestaurant()
        }
    }
    @objc func tapFreeDeliverySwitch(){
           
        if freeDeliverySwitch.isOn {
            freeDeliveryMinimumAmtTxtFld.isHidden = false
        }else{
            freeDeliveryMinimumAmtTxtFld.isHidden = true
        }
          
       }
    
    @objc func tapIsVeg(_ sender:UIButton)  {
        isVeg = sender.tag == 0
    }
    
    @objc func tapUploadImageButton() {
        self.showImage(isRemoveNeed: nil, with:{ (image) in
            self.uploadImageView.image = image
            self.isImageEdit = 1
        })
    }
    
    private func createEditRestaurant(){
        
        let countryCode = ((countryCodeTextField.text ?? "").trimString())
        var parameter: Parameters = [
            AccountConstant.PStoreName:nameTextField.text ?? "",
            AccountConstant.PEmail:emailTextField.text ?? "",
            AccountConstant.PEstimatedDeliveryTime: deliveryTimeTextField.text ?? "",
            AccountConstant.PContactNumber: mobileTextField.text ?? "",
            AccountConstant.PStoreLocation: landMarkTextField.text ?? "",
            AccountConstant.PLatitude:latitude,
            AccountConstant.PLongitude:longitude,
            AccountConstant.PStoreZipcode:zipCodeTextField.text ?? "",
            AccountConstant.PContactPerson:contactPersonTextField.text ?? "",
            AccountConstant.PStorePackingCharges:storePackageChargeTextField.text ?? "",
            AccountConstant.PZoneId:selectedZoneId,
            AccountConstant.PStoreGst:gstTaxTextField.text ?? "",
            AccountConstant.POfferMinAmount:minAmtField.text ?? "",
            AccountConstant.POfferPercent:offerPercentTextField.text ?? "",
            AccountConstant.PDescription:descriptionTextField.text ?? "",
            AccountConstant.PCountryId:self.editRestaurant?.responseData?.country_id ?? 0,
            AccountConstant.PCityId:selectedCityId,
            AccountConstant.PCommission:comissionTextField.text ?? "",
            AccountConstant.PCountryCode:countryCode.dropFirst(),
            AccountConstant.PMethod:ProductConstant.PPatch,
            AccountConstant.PId: String(AppManager.shared.storeId ?? 0),
            AccountConstant.PStoreTypeId: AppManager.shared.storeTypeid ?? 0,
            AccountConstant.PStoreResponseTime: shopResponseTimeTextField.text ?? "",
            AccountConstant.PFlat_no:flatNoTextField.text ?? "",
            AccountConstant.PStreet:streetTextField.text ?? "",
            AccountConstant.Pbestseller:bestSellerCountTxtFld.text ?? "",
            AccountConstant.Pbestseller_month:bestSellerMonthTxtFld.text ?? ""]
        
        for i in 0..<selectedCuisineData.count {
            let dict = selectedCuisineData[i]
            let cuisineIdStr = AccountConstant.PCuisineId + "[\(i)]"
            parameter[cuisineIdStr] = dict.id
        }
        if isVeg {
            parameter[AccountConstant.PIsVeg] = 1
        }else{
            parameter[AccountConstant.PIsVeg] = 0
        }
        
        if freeDeliverySwitch.isOn {
             parameter[AccountConstant.Pfree_delivery_limit] = freeDeliveryMinimumAmtTxtFld.text ?? ""
            parameter[AccountConstant.Pfree_delivery] = 1
        }else{
             parameter[AccountConstant.Pfree_delivery] = 0
              parameter[AccountConstant.Pfree_delivery_limit] = freeDeliveryMinimumAmtTxtFld.text ?? ""
        }
        
        if statusTextField.text == AccountConstant.enable {
            parameter[AccountConstant.PStatus] = 1
        }else{
            parameter[AccountConstant.PStatus] = 0
        }
        
        if isImageEdit == 1 {
            var shopImageData: Data!
            if  let shopData = uploadImageView.image?.jpegData(compressionQuality: 0.5) {
                shopImageData = shopData
            }
            if shopImageData != nil {
                self.accountPresenter?.editRestaurant(param: parameter, imageData: [ProductConstant.PPicture:shopImageData])
            }
        }else{
            self.accountPresenter?.editRestaurant(param: parameter, imageData: nil)
            
        }
        
    }
}

//MARK:- UITextFieldDelegate

extension EditRestaurantController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing()
        switch textField {
        case landMarkTextField:
            let placePickerController = GMSAutocompleteViewController()
            placePickerController.delegate = self
            present(placePickerController, animated: true, completion: nil)
            return false
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
        case zoneTextField:
              if zoneArr.count > 0{
            PickerManager.shared.showPicker(pickerData: zoneArr, selectedData: nil) { [weak self] (selectedType) in
                guard let self = self else {
                    return
                }
                self.zoneTextField.text = selectedType
                for i in 0..<(self.editRestaurant?.responseData?.zone_data?.count ?? 0){
                    let dict = self.editRestaurant?.responseData?.zone_data?[i]
                    if selectedType == dict?.name {
                        
                        self.selectedZoneId = dict?.id ?? 0
                    }
                }
                
                self.view.setNeedsUpdateConstraints()
                self.view.layoutIfNeeded()
            }
              }
            return false
            
        case countryCodeTextField:
            showPicker(pickerType: .countryCode)
            return false
        case cityTextField:
            guard let stateStr = countryTextField.text, !stateStr.isEmpty else{
                AppAlert.shared.simpleAlert(view: self, title: AccountConstant.cityEmpty.localized, message: nil)
                return false
            }
            showPicker(pickerType: .cityList)
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
    
    private func showPicker(pickerType: PickerType) {
        let countryCodeView = self.storyboard?.instantiateViewController(withIdentifier: AccountConstant.CountryCodeViewController) as! CountryCodeViewController
        countryCodeView.pickerType = pickerType
        if pickerType == .cityList {
            countryCodeView.cityListEntity = cityDataArr
            countryCodeView.selectedCity = { [weak self] cityDetail in
                guard let self = self else {
                    return
                }
                self.cityTextField.text = cityDetail.city?.city_name
                self.selectedCityId = cityDetail.id ?? 0
            }
        }else {
            countryCodeView.countryCode = { [weak self] countryDetail in
                guard let self = self else {
                    return
                }
                self.countryDetail = countryDetail
            }
        }
        self.present(countryCodeView, animated: true, completion: nil)
    }
}

//MARK:- AccountPresenterToAccountViewProtocol

extension EditRestaurantController: AccountPresenterToAccountViewProtocol {
    
    func getEditRestaurantSuccess(editRestaurantEntity: EditRestaurantEntity) {
        editRestuarant(editRestaurant: editRestaurantEntity.responseData!)
        self.editRestaurant = editRestaurantEntity
    }
    
    func editRestaurantSuccess(editRestaurantEntity: CreateAddonsEntity) {
        ToastManager.show(title: editRestaurantEntity.message ?? "", state: .success)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func editRestuarant(editRestaurant: EditResturantData){
        cityDataArr.removeAll()
        nameTextField.text = editRestaurant.store_name
        mobileTextField.text = editRestaurant.contact_number
        if editRestaurant.status == 1 {
            statusTextField.text = AccountConstant.enable
        }else{
            statusTextField.text = AccountConstant.disable
        }
        if editRestaurant.free_delivery == 1{
            freeDeliverySwitch.setOn(true, animated: false)
            freeDeliveryMinimumAmtTxtFld.isHidden = false
        }else{
             freeDeliverySwitch.setOn(false, animated: false)
             freeDeliveryMinimumAmtTxtFld.isHidden = true
        }
        
        
        gstTaxTextField.text = editRestaurant.store_gst?.toString()
        storePackageChargeTextField.text = editRestaurant.store_packing_charges?.toString()
        comissionTextField.text = editRestaurant.commission?.toString()
        selectedCityId = editRestaurant.city_id ?? 0
        emailTextField.text = editRestaurant.email
        landMarkTextField.text = editRestaurant.store_location
        cityTextField.text = editRestaurant.city_data?.first?.city?.city_name
        deliveryTimeTextField.text = editRestaurant.estimated_delivery_time
        minAmtField.text = editRestaurant.offer_min_amount
        offerPercentTextField.text = editRestaurant.offer_percent?.toString()
        descriptionTextField.text = editRestaurant.description
        zipCodeTextField.text = editRestaurant.store_zipcode
        contactPersonTextField.text = editRestaurant.contact_person
        flatNoTextField.text = editRestaurant.flat_no
        streetTextField.text = editRestaurant.street
        shopResponseTimeTextField.text = editRestaurant.store_response_time?.toString()
        freeDeliveryMinimumAmtTxtFld.text = editRestaurant.free_delivery_limit
        bestSellerCountTxtFld.text = editRestaurant.bestseller?.toString()
        bestSellerMonthTxtFld.text = editRestaurant.bestseller_month?.toString()
        
        if let shopImageUrl = URL(string: editRestaurant.picture ?? ""){
            uploadImageView.sd_setImage(with: shopImageUrl, placeholderImage: UIImage(named: ProductConstant.ic_Product_upload))
        }else{
            uploadImageView.image = UIImage(named: ProductConstant.ic_Product_upload)
        }
        longitude = editRestaurant.longitude ?? 0
        latitude = editRestaurant.latitude ?? 0
        if editRestaurant.is_veg == AccountConstant.nonVeg {
            self.isVeg = false
        }else{
            self.isVeg = true
        }
        
        let countryCode = "+" + (editRestaurant.country_code?.toString() ?? "")
        selectedZoneId = editRestaurant.zone_id ?? 0
        for i in 0..<(editRestaurant.city_data?.count ?? 0){
            let dict = editRestaurant.city_data?[i]
            cityDataArr.append(dict!)
            if dict?.city_id == editRestaurant.city_id {
                cityTextField.text = dict?.city?.city_name
            }
        }
        
        if ((Locale.current as NSLocale).object(forKey: .countryCode) as? String) != nil {
            let countryCodeList = AppUtils.shared.getCountries()
            for eachCountry in countryCodeList {
                if eachCountry.dial_code == countryCode{
                    countryDetail = Country(name: eachCountry.name, dial_code: eachCountry.dial_code, code: eachCountry.code)
                }
            }
        }
        var selectedCuisine:[String] = []
        
        for i in 0..<(editRestaurant.cuisine_data?.count ?? 0)
        {
            let dict = editRestaurant.cuisine_data?[i]
            
            if editRestaurant.cui_selectdata?.contains(dict?.id ?? 0) ?? false {
                selectedCuisine.append(dict?.name ?? "")
                selectedCuisineData.append(dict!)
            }
            
        }
        let joinedCuisineData = selectedCuisine.joined(separator: ", ")
        
        cusineLabel.text = joinedCuisineData
        
        let height = heightForView(text: joinedCuisineData, font: UIFont.systemFont(ofSize: 14), width: 300)
        print(height)
        heightConstaint?.constant = height
        
        let baseConfig = AppConfigurationManager.shared.baseConfigModel
        
        let countryArr = baseConfig?.responseData?.country
        for i in 0..<(countryArr?.count ?? 0)
        {
            let dict = countryArr?[i]
            if dict?.country_id == editRestaurant.country_id {
                countryTextField.text = dict?.country?.country_name
            }
        }
        
        for i in 0..<(editRestaurant.zone_data?.count ?? 0){
            let dict = editRestaurant.zone_data?[i]
            zoneArr.append(dict?.name ?? "")
            if editRestaurant.zone_id == dict?.id {
                zoneTextField.text = dict?.name
                return
            }
        }
    }
}

//MARK:- GMSAutocompleteViewControllerDelegate

extension EditRestaurantController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        landMarkTextField.text = place.formattedAddress
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(landMarkTextField.text ?? "") {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            // print("Lat: \(lat), Lon: \(lon)")
            self.latitude = lat ?? 0
            self.longitude = lon ?? 0
        }
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

//MARK:- SelectCuisineDelegate

extension EditRestaurantController: SelectCuisineDelegate {
    func didSelectCuisine(data: [Cuisine_data]) {
        selectedCuisineData = data
        var selectedCuisine:[String] = []
        for i in 0..<(selectedCuisineData.count){
            let dict = selectedCuisineData[i]
            selectedCuisine.append(dict.name ?? "")
        }
        let joinedCuisineData = selectedCuisine.joined(separator: ", ")
        cusineLabel.text = joinedCuisineData
        let height = heightForView(text: joinedCuisineData, font: UIFont.systemFont(ofSize: 14), width: 300)
        print(height)
        heightConstaint?.constant = height
    }
}

func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    
    label.sizeToFit()
    return label.frame.height
}
