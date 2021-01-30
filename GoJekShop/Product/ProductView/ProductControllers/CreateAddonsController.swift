//
//  CreateAddonsController.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Alamofire

class CreateAddonsController: UIViewController {
    
    @IBOutlet weak var outterView: UIView!
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var addonsData: AddonsData?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initalLoads()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        saveButton.setCornerRadius()
    }
    
    private func initalLoads(){
        setNavigationTitle()
        nameTextField.font = .setCustomFont(name: .medium, size: .x14)
        saveButton.titleLabel?.font = .setCustomFont(name: .bold, size: .x14)
        saveButton.setTitle(Constant.SSave, for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .appPrimaryColor
        saveButton.addTarget(self, action: #selector(tapSave), for: .touchUpInside)
        nameTextField.placeholder = Constant.SName.localized
        setLeftBarButtonWith(color: .blackColor, leftButtonImage: Constant.ic_back)
        self.title = ProductConstant.createAddons.localized
        self.view.backgroundColor = .backgroundColor
        outterView.backgroundColor = .boxColor
        if addonsData != nil {
            nameTextField.text = addonsData?.addon_name
        }
            
    }
    
    private func createAddonsApi(){
        let parameter: Parameters = [
            ProductConstant.PaddonName:nameTextField.text ?? "",
            ProductConstant.PaddonStatus:1,
            ProductConstant.PStoreId: String(AppManager.shared.storeId ?? 0)
            
        ]
        productPresenter?.addAddons(param: parameter)
    }
    
    private func editAddonsApi(){
        let parameter: Parameters = [
            ProductConstant.PaddonName:nameTextField.text ?? "",
            ProductConstant.PStoreId: String(AppManager.shared.storeId ?? 0),
            ProductConstant.Pmethod: ProductConstant.PPatch
            
        ]
        productPresenter?.editAddons(Id: addonsData?.id?.toString() ?? "", param: parameter)
    }
    
    @objc func tapSave() {
        if validation(){
            if addonsData == nil {
                createAddonsApi()
                
            }else{
                editAddonsApi()
            }
        }
    }
    
    private func validation() -> Bool {
        guard let nameStr = nameTextField.text?.trimString(), !nameStr.isEmpty else {
            ToastManager.show(title: ProductConstant.enterAddonName.localized , state: .error)
            return false
        }
        return true
    }
}

//MARK:- ProductPresenterToProductViewProtocol

extension CreateAddonsController: ProductPresenterToProductViewProtocol {
    
    func createAddonsSuccess(createAddonsEntity: CreateAddonsEntity) {
        ToastManager.show(title: ProductConstant.addonsSuccess, state: .success)
        self.navigationController?.popViewController(animated: true)
        
    }
}
