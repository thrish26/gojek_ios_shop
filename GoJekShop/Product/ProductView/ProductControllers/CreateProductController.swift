//
//  CreateProductController.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Alamofire

class CreateProductController: UIViewController {
    
    @IBOutlet weak var lowStockTextField: CustomTextField!
    @IBOutlet weak var availablityLabel: UILabel!
    @IBOutlet weak var availablitySwitch: UISwitch!
    @IBOutlet weak var availablityView: UIView!
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var desTextField: CustomTextField!
    @IBOutlet weak var statusTextField: CustomTextField!
    @IBOutlet weak var categoryTextField: CustomTextField!
    @IBOutlet weak var imageUploadLabel: UILabel!
    @IBOutlet weak var imageUploadButton: UIButton!
    @IBOutlet weak var uploadImageLabel: UILabel!
    @IBOutlet weak var imageFormatLabel: UILabel!
    @IBOutlet weak var priceTextField: CustomTextField!
    @IBOutlet weak var discountTypeTextField: CustomTextField!
    @IBOutlet weak var discountTextField: CustomTextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageOverView: UIView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var overSubView: UIView!
    @IBOutlet weak var productImageview: UIImageView!
    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var pureVegButton: UIButton!
    @IBOutlet weak var nonVegButton: UIButton!
    @IBOutlet weak var heightConstaint: NSLayoutConstraint?
    @IBOutlet weak var selectAddonsLabel: UILabel!
    @IBOutlet weak var selectAddonsImageview: UIImageView!
    @IBOutlet weak var selectAddonsView: UIView!
    @IBOutlet weak var purevegBGVw: UIView!
    @IBOutlet weak var qtyTextField: CustomTextField!
    @IBOutlet weak var unitTextField: CustomTextField!
    
    var statusArr = [AccountConstant.disable, AccountConstant.enable]
    var discountTypeArr = ["PERCENTAGE","AMOUNT"]
    var unitArr:[UnitResponseData] = []
    var offSet: Int = 0
    var isUpdate = false
    var totalRecord = 0
    var categoryData :CategoryData?
    var productData :ProductData?
    var addonsList:[AddonsListResponseData] = []
    var priceArr:NSMutableArray = []
    var IdArr:NSMutableArray = []
    let addonsName:NSMutableArray = []

    var productImageData: Data!
    var category_id = 0
    var unit_id = 0
    var productItemId = 0

    
    var isVegOrNonVeg:Bool = false {
        didSet {
            pureVegButton.setImage(UIImage(named: isVegOrNonVeg ? Constant.circleFullImage : Constant.circleImage), for: .normal)
            nonVegButton.setImage(UIImage(named: isVegOrNonVeg ? Constant.circleImage : Constant.circleFullImage ), for: .normal)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initalLoads()
    }
    override func viewWillAppear(_ animated: Bool) {
        if categoryData != nil {
            categoryTextField.text = categoryData?.store_category_name
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        saveButton.setCornerRadius()
        productImageview.setCornerRadiuswithValue(value: 8)
        imageOverView.setCornerRadiuswithValue(value: 10)
        selectAddonsView.setCornerRadius()
    }
    
    private func initalLoads(){
        availablitySwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        getUnitList()
        setFont()
        setInitalTitle()
        selectAddonsView.layer.borderColor = UIColor.black.cgColor
        selectAddonsView.layer.borderWidth = 1
        selectAddonsLabel.textColor = .black
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.saveView.frame.height + 10, right: 0)
        saveButton.setTitle(Constant.SSave.localized, for: .normal)
        saveButton.titleLabel?.font = .setCustomFont(name: .bold, size: .x14)
        hideTabBar()
        self.title = ProductConstant.createProduct.localized
        imageUploadButton.addTarget(self, action: #selector(tapImage), for: .touchUpInside)
        setDelegate()
        setColor()
        pureVegButton.addTarget(self, action: #selector(tapVegorNonVeg(_:)), for: .touchUpInside)
        nonVegButton.addTarget(self, action: #selector(tapVegorNonVeg(_:)), for: .touchUpInside)
        pureVegButton.setImageTitle(spacing: 10)
        nonVegButton.setImageTitle(spacing: 10)
        productImageview.image = UIImage(named: ProductConstant.ic_Product_upload)
        pureVegButton.setTitleColor(.black, for: .normal)
        nonVegButton.setTitleColor(.black, for: .normal)
        nonVegButton.tintColor = .black
        pureVegButton.tintColor = .black
        saveButton.addTarget(self, action: #selector(TapOnSaveAction), for: .touchUpInside)
        priceTextField.keyboardType = .numberPad
        isVegOrNonVeg = true

        selectAddonsImageview.image = UIImage(named:  ProductConstant.ic_plus)?.imageTintColor(color1: .lightGray)
        let selectAddonsGuesture = UITapGestureRecognizer(target: self, action: #selector(tapSelectAddons))
        selectAddonsView.addGestureRecognizer(selectAddonsGuesture)
        
        selectAddonsLabel.textColor = .lightGray
        if productData != nil {
            nameTextField.text = productData?.item_name
            desTextField.text = productData?.item_description
            if productData?.status == 1 {
                statusTextField.text = AccountConstant.enable
                self.availablityView.isHidden = false
                self.availablitySwitch.isOn = true
            }else if productData?.status == 2{
                statusTextField.text = AccountConstant.disable
                self.availablityView.isHidden = true
            }
            else{
                statusTextField.text = AccountConstant.enable
                self.availablityView.isHidden = false
                self.availablitySwitch.isOn = false
            }
            priceTextField.text = productData?.item_price?.toString()
            discountTypeTextField.text = productData?.item_discount_type
            discountTextField.text = productData?.item_discount?.toString()
          //  unitTextField.text = productData?.unit
            qtyTextField.text = productData?.quantity?.toString()
            lowStockTextField.text = productData?.lowStock?.toString()
            category_id = productData?.store_category_id ?? 0
            unit_id = productData?.unit_id ?? 0
            if  productData?.is_veg == "Pure Veg"{
                isVegOrNonVeg = true

            }else{
                isVegOrNonVeg = false

            }

            productItemId = productData?.id ?? 0
            if let productImageUrl = URL(string: productData?.picture ?? ""){
                       productImageview.sd_setImage(with: productImageUrl, placeholderImage: UIImage(named: ProductConstant.ic_Product_upload))
                       
                   }else{
                       productImageview.image = UIImage(named: ProductConstant.ic_Product_upload)
                   }
            getCategoryList()

        }
       
        checkShopType()
    }
    
    private func getCategoryList() {
            let parameter: Parameters = [
                ProductConstant.PLimit:100,
                ProductConstant.POffset:0
            ]
            productPresenter?.getCategory(param: parameter, isShowLoader: true)
        }
    private func getUnitList() {
               productPresenter?.getUnits()
           }
    
    @objc func tapSelectAddons() {
        let selectAddonsViewController = self.storyboard?.instantiateViewController(withIdentifier: ProductConstant.VSelectAddonsViewController) as! SelectAddonsViewController
        selectAddonsViewController.delegate = self
        selectAddonsViewController.addonsName = addonsName
        selectAddonsViewController.IdArr = IdArr
        selectAddonsViewController.priceArr = priceArr
        selectAddonsViewController.addonsList = addonsList
        self.navigationController?.pushViewController(selectAddonsViewController, animated: true)
    }
    
    private func setColor(){
        setNavigationTitle()
        saveView.backgroundColor = .backgroundColor
        self.view.backgroundColor = .backgroundColor
        overView.backgroundColor = .backgroundColor
        overSubView.backgroundColor = .boxColor
        imageOverView.backgroundColor = .backgroundColor
        imageFormatLabel.textColor = .lightGray
        saveButton.backgroundColor = .appPrimaryColor
        saveButton.setTitleColor(.white, for: .normal)
        self.setLeftBarButtonWith(color: .blackColor)
    }
    
    private func setDelegate(){
        nameTextField.delegate = self
        desTextField.delegate = self
        statusTextField.delegate = self
        categoryTextField.delegate = self
        priceTextField.delegate = self
        discountTypeTextField.delegate = self
        discountTextField.delegate = self
        qtyTextField.delegate  = self
        unitTextField.delegate = self
        discountTextField.keyboardType = .numberPad
        qtyTextField.keyboardType = .numberPad
    }
     
    private func setInitalTitle(){
        saveButton.setTitle(Constant.SSave.localized, for: .normal)
        priceTextField.placeholder = ProductConstant.price.localized
        discountTypeTextField.placeholder = ProductConstant.discountType.localized
        discountTextField.placeholder = ProductConstant.discount.localized
        qtyTextField.placeholder = ProductConstant.quantity.localized
        unitTextField.placeholder = ProductConstant.unit.localized
        selectAddonsLabel.text = ProductConstant.selectAddons.localized
        nameTextField.placeholder = Constant.SName.localized
        lowStockTextField.placeholder = Constant.lowStock.localized
        desTextField.placeholder = ProductConstant.description.localized
        categoryTextField.placeholder = ProductConstant.category.localized
        imageUploadLabel.text = ProductConstant.imageUpload.localized
        uploadImageLabel.text = ProductConstant.uploadImage.localized
        imageFormatLabel.text = ProductConstant.imageFormat.localized
        statusTextField.placeholder = ProductConstant.status.localized
        availablityLabel.text = ProductConstant.availablity.localized
        pureVegButton.setTitle(isVegorNonVeg.pureVeg.rawValue.localized, for: .normal)
        nonVegButton.setTitle(isVegorNonVeg.nonVeg.rawValue.localized, for: .normal)
    }
    
    private func setFont(){
        nameTextField.font = .setCustomFont(name: .medium, size: .x14)
        desTextField.font = .setCustomFont(name: .medium, size: .x14)
        lowStockTextField.font = .setCustomFont(name: .medium, size: .x14)
        categoryTextField.font = .setCustomFont(name: .medium, size: .x14)
        priceTextField.font = .setCustomFont(name: .medium, size: .x14)
        discountTypeTextField.font = .setCustomFont(name: .medium, size: .x14)
        discountTextField.font = .setCustomFont(name: .medium, size: .x14)
        availablityLabel.font = .setCustomFont(name: .medium, size: .x14)
        qtyTextField.font = .setCustomFont(name: .medium, size: .x14)
        unitTextField.font = .setCustomFont(name: .medium, size: .x14)
        selectAddonsLabel.font = .setCustomFont(name: .medium, size: .x14)
        saveButton.titleLabel?.font = .setCustomFont(name: .bold, size: .x14)
        imageUploadLabel.font = .setCustomFont(name: .medium, size: .x14)
        statusTextField.font = .setCustomFont(name: .medium, size: .x14)
        uploadImageLabel.font = .setCustomFont(name: .medium, size: .x14)
        imageFormatLabel.font = .setCustomFont(name: .medium, size: .x12)
        
    }
    private func checkShopType(){
           if AppManager.shared.storeType == "OTHERS" {
              purevegBGVw.isHidden = true
              selectAddonsView.isHidden = true
              lowStockTextField.isHidden = false
           }else{
             purevegBGVw.isHidden = false
             selectAddonsView.isHidden = false
             lowStockTextField.isHidden = true
           }
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
        
        guard let categoryStr = categoryTextField.text?.trimString(), !categoryStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: ProductConstant.categoryEmpty.localized, message: nil)
            return false
        }
        if productImageview.image == UIImage(named: ProductConstant.ic_Product_upload) {
            AppAlert.shared.simpleAlert(view: self, title: ProductConstant.productImageEmpty.localized, message: nil)
            return false

        }
        guard let qtyStr = qtyTextField.text?.trimString(), !qtyStr.isEmpty else {
                   AppAlert.shared.simpleAlert(view: self, title: ProductConstant.qtyEmpty.localized, message: nil)
                   return false
               }
             
//               guard let unitStr = unitTextField.text?.trimString(), !unitStr.isEmpty else {
//                   AppAlert.shared.simpleAlert(view: self, title: ProductConstant.unitEmpty.localized, message: nil)
//                   return false
//               }
        guard let priceStr = priceTextField.text?.trimString(), !priceStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: ProductConstant.priceEmpty.localized, message: nil)
            return false
        }
      
        guard let discountTypeStr = discountTypeTextField.text?.trimString(), !discountTypeStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: ProductConstant.discountTypeEmpty.localized, message: nil)
            return false
        }
        guard let discountStr = discountTextField.text?.trimString(), !discountStr.isEmpty else {
                  AppAlert.shared.simpleAlert(view: self, title: ProductConstant.discountEmpty.localized, message: nil)
                  return false
              }

   
        return true
    }
    
    @objc func tapVegorNonVeg(_ sender:UIButton) {
        isVegOrNonVeg = sender.tag == 0
    }
    
    @objc func TapOnSaveAction() {

        if validation() {
            if  let productData = productImageview.image?.jpegData(compressionQuality: 0.5) {
                      productImageData = productData
            }
            if productImageData == nil {
                AppAlert.shared.simpleAlert(view: self, title: ProductConstant.productImageEmpty.localized, message: nil)
                
            }else{
                if self.productData != nil {
                    editProductApi()
                }else{
                    createUpdateProductApi()

                }
            }
        }
    }
    
    
    private func editProductApi(){
        
        let discountType = discountTypeTextField.text ?? ""
       
               for i in 0..<(unitArr.count){
                            //  let dict = unitArr[i]
                   if  unitArr[i].name == unitTextField.text {
                       unit_id = unitArr[i].id ?? 0
                         
                   }
                   }
        var parameter: Parameters = [
            ProductConstant.PItemName:nameTextField.text ?? "",
            ProductConstant.PStoreId:String(AppManager.shared.storeId ?? 0),
            ProductConstant.PItemDescription: desTextField.text ?? "",
            ProductConstant.PStoreCategory_id: category_id,
            ProductConstant.PItemPrice: priceTextField.text ?? "",
            ProductConstant.PItemDiscount: discountTextField.text ?? "",
            ProductConstant.PItemDiscountType: discountType,
            ProductConstant.PUnit: String(unit_id),
            ProductConstant.PQty: qtyTextField.text ?? "",
            ProductConstant.Pmethod: ProductConstant.PPatch,
            ProductConstant.PLowStock:lowStockTextField.text ?? ""

        ]
        if isVegOrNonVeg {
            parameter[ProductConstant.PIsVeg] = 1
            
        }else {
            parameter[ProductConstant.PIsVeg] = 0
        }
        
        if (statusTextField.text == AccountConstant.enable) && (availablitySwitch.isOn == false) {
            parameter[ProductConstant.PStatus] = 0
        }
        else if (statusTextField.text == AccountConstant.enable) && (availablitySwitch.isOn == true){
           parameter[ProductConstant.PStatus] = 1
        }
        else{
            parameter[ProductConstant.PStatus] = 2
        }
        
        for i in 0..<IdArr.count {
            let dict = IdArr[i] as? Int
            if dict != 0 {
                let addonsIdStr = ProductConstant.PAddon + "[\(i)]"
                parameter[addonsIdStr] = dict
            }
        }
        for i in 0..<priceArr.count {
            let dict = priceArr[i] as? String
            if dict != "0" {
                
                //let addonsPriceStr = ProductConstant.PAddonPrice + "[\(i)]"
                let addonsPriceStr = ProductConstant.PAddonPrice + "[\(IdArr[i])]"
                parameter[addonsPriceStr] = dict
            }
        }
        
        if productImageData != nil {
            
            productPresenter?.editProduct(param: parameter,id: productData?.id?.toString() ?? "0", imageData: [ProductConstant.PPicture:productImageData])
        }
    }
    
    private func createUpdateProductApi(){
        let discountType = discountTypeTextField.text ?? ""
        for i in 0..<(unitArr.count){
                     //  let dict = unitArr[i]
            if  unitArr[i].name == unitTextField.text {
                unit_id = unitArr[i].id ?? 0
                  
            }
            }
        
        var parameter: Parameters = [
            ProductConstant.PItemName:nameTextField.text ?? "",
            ProductConstant.PStoreId:String(AppManager.shared.storeId ?? 0),
            ProductConstant.PItemDescription: desTextField.text ?? "",
            ProductConstant.PStoreCategory_id: categoryData?.id ?? 0,
            ProductConstant.PItemPrice: priceTextField.text ?? "",
            ProductConstant.PItemDiscount: discountTextField.text ?? "",
            ProductConstant.PItemDiscountType: discountType,
            ProductConstant.PUnit: String(unit_id),
            ProductConstant.PQty: qtyTextField.text ?? "",
       
        ]
        if isVegOrNonVeg {
            parameter[ProductConstant.PIsVeg] = 1
            
        }else {
            parameter[ProductConstant.PIsVeg] = 0
        }
        
            if (statusTextField.text == AccountConstant.enable) && (availablitySwitch.isOn == false) {
            parameter[ProductConstant.PStatus] = 0
        }
        else if (statusTextField.text == AccountConstant.enable) && (availablitySwitch.isOn == true){
           parameter[ProductConstant.PStatus] = 1
        }
        else{
            parameter[ProductConstant.PStatus] = 2
        }
        
        for i in 0..<IdArr.count {
            let dict = IdArr[i] as? Int
            if dict != 0 {
                let addonsIdStr = ProductConstant.PAddon + "[\(i)]"
                parameter[addonsIdStr] = dict
            }
        }
        for i in 0..<priceArr.count {
            let dict = priceArr[i] as? String
            if dict != "0" {
                
               // let addonsPriceStr = ProductConstant.PAddonPrice + "[\(i)]"
                 let addonsPriceStr = ProductConstant.PAddonPrice + "[\(IdArr[i])]"
                parameter[addonsPriceStr] = dict
            }
        }
        
        if productImageData != nil {
            
            productPresenter?.addProduct(param: parameter, imageData: [ProductConstant.PPicture:productImageData])
        }
    }
    
    @objc func tapImage() {
        self.showImage(isRemoveNeed: nil, with:{ (image) in
            self.productImageview.image = image
        })
    }
}

//MARK:- ProductPresenterToProductViewProtocol

extension CreateProductController: ProductPresenterToProductViewProtocol {
    func createProductSuccess(createProductEntity: CreateProductEntity) {
        ToastManager.show(title: ProductConstant.productEmpty, state: .success)
        self.navigationController?.popViewController(animated: true)
    }
    func editProductSuccess(editProductEntity: CreateProductEntity) {
        ToastManager.show(title: ProductConstant.productEmpty, state: .success)
              self.navigationController?.popViewController(animated: true)
    }
    func getAddonsListSuccess(addonEntity: AddonsListEntity) {
        addonsList = addonEntity.responseData ?? []

        for i in 0..<(addonsList.count) {
            let data = addonsList[i]
            if data.storeitem != nil {
                
                IdArr.add(data.storeitem?.store_addon_id ?? 0)
                priceArr.add(data.storeitem?.price?.toString() ?? "0")
                addonsName.add(data.addon_name ?? String.empty)
                
            }else{
                IdArr.add(0)
                priceArr.add("0")
                addonsName.add(String.empty)
            }
        }
        let addonsNameArr:NSMutableArray = []

        for i in 0..<addonsName.count {
                   let dict = addonsName[i] as? String
                   if dict != String.empty {
                       addonsNameArr.add(dict ?? String.empty)
                   }
               }
        if addonsNameArr.count != 0 {
            selectAddonsLabel.textColor = .black

               let addonsArrStr = addonsNameArr.componentsJoined(by: ",")
               selectAddonsLabel.text = addonsArrStr

            }
    }
    func getUnitSuccess(unitEntity: UnitEntity) {
        unitArr = unitEntity.responseData ?? []
               for i in 0..<(unitArr.count){
                let dict = unitArr[i]
          if dict.id == unit_id {
            unitTextField.text = dict.name
                }
                //unitArr.add(dict.name ?? String.Empty)
     }
    }
    
    func getCategorySuccess(getCategoryEntity: GetCategoryEntity) {
        let categoryArr = getCategoryEntity.responseData?.data ?? []
        for i in 0..<(categoryArr.count){
            let dict = categoryArr[i]
            if dict.id == category_id {
                categoryTextField.text = dict.store_category_name
            }            
        }
      
        productPresenter?.getAddonsList(Id: productItemId.toString())

        
    }
    
}

//MARK:- UITextFieldDelegate

extension  CreateProductController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing()
        switch textField {
        case statusTextField:
            PickerManager.shared.showPicker(pickerData: statusArr, selectedData: nil) { [weak self] (selectedType) in
                guard let self = self else {
                    return
                }
                self.statusTextField.text = selectedType
                if(selectedType == "Disable"){
                    self.availablityView.isHidden = true
                }
                else{
                    self.availablityView.isHidden = false
                }
                self.view.setNeedsUpdateConstraints()
                self.view.layoutIfNeeded()
            }
            return false
        case categoryTextField:
            let categoryViewController = self.storyboard?.instantiateViewController(withIdentifier: ProductConstant.VCategoryViewController) as! CategoryViewController
            self.navigationController?.pushViewController(categoryViewController, animated: true)
            return false
        case discountTypeTextField:
            PickerManager.shared.showPicker(pickerData: discountTypeArr, selectedData: nil) { [weak self] (selectedType) in
                guard let self = self else {
                    return
                }
                self.discountTypeTextField.text = selectedType
                self.view.setNeedsUpdateConstraints()
                self.view.layoutIfNeeded()
            }
            return false
            case unitTextField:
                if unitArr.count > 0 {
                let unitnameArr:NSMutableArray = []
                for dict in unitArr{
                    unitnameArr.add(dict.name ?? String.Empty)
                }
                
                PickerManager.shared.showPicker(pickerData:unitnameArr as! [String] , selectedData: nil) { [weak self] (selectedType) in
                           guard let self = self else {
                               return
                           }
                           self.unitTextField.text = selectedType
                           self.view.setNeedsUpdateConstraints()
                           self.view.layoutIfNeeded()
                       }
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

//MARK:- SelectAddonsDataDelegate

extension CreateProductController: SelectAddonsDataDelegate {
    func selectedAddons(id: NSMutableArray, price: NSMutableArray,addonsName: NSMutableArray) {
        let addonsNameArr:NSMutableArray = []

        addonsNameArr.removeAllObjects()
        IdArr = id
        priceArr = price
        
        for i in 0..<addonsName.count {
            let dict = addonsName[i] as? String
            if dict != String.empty {
                addonsNameArr.add(dict ?? String.empty)
            }
        }
        if addonsNameArr.count != 0 {

        let addonsArrStr = addonsNameArr.componentsJoined(by: ",")
        selectAddonsLabel.text = addonsArrStr
        selectAddonsLabel.textColor = .black

        let height = heightForView(text: addonsArrStr, font: UIFont.systemFont(ofSize: 14), width: 300)
        print(height)
        heightConstaint?.constant = height
        }
        
    }
}
