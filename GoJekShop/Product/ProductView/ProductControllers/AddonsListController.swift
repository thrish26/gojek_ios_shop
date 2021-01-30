//
//  AddonsListController.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Alamofire

class AddonsListController: UIViewController {
    
    @IBOutlet weak var addonsTableView: UITableView!
    @IBOutlet weak var addAddonsButton: UIButton!
    
    var addonsArr : [AddonsData] = []
    var offSet: Int = 0
    var isUpdate = false
    var totalRecord = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initalLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addAddonsButton.setCornerRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAddonsList()
        
    }
    
    private func initalLoad(){
        addonsTableView.register(nibName: ProductConstant.TAddOnsListTableViewCell)
        self.hideTabBar()
        setNavigationTitle()
        self.view.backgroundColor = .backgroundColor
        addonsTableView.backgroundColor = .backgroundColor
        self.addonsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.addAddonsButton.frame.height + 10, right: 0)
        addAddonsButton.setTitle(ProductConstant.addAddons, for: .normal)
        addAddonsButton.setTitleColor(.white, for: .normal)
        addAddonsButton.backgroundColor = .appPrimaryColor
        addAddonsButton.titleLabel?.font = .setCustomFont(name: .bold, size: .x14)
        self.setLeftBarButtonWith(color: .blackColor)
        self.title = ProductConstant.addonsList.localized
        addAddonsButton.addTarget(self, action: #selector(TapOnAddAddonAction), for: .touchUpInside)
        
    }
    
    private func getAddonsList() {
        let parameter: Parameters = [
            ProductConstant.PLimit:10,
            ProductConstant.POffset:offSet
        ]
        productPresenter?.getAddonsList(param: parameter, isShowLoader: isUpdate ? false : true)
    }
    
    
    @objc func TapOnAddAddonAction() {
        let createAddonsController = self.storyboard?.instantiateViewController(withIdentifier: ProductConstant.VCreateAddonsController) as! CreateAddonsController
        self.navigationController?.pushViewController(createAddonsController, animated: true)
    }
}

//MARK:- UITableViewDataSource

extension AddonsListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addonsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductConstant.TAddOnsListTableViewCell, for: indexPath) as! AddOnsListTableViewCell
        
        let dict = addonsArr[indexPath.row]
        cell.delegate = self
        cell.setAddonsData(addonsDict: dict,tagIndex: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = addonsArr[indexPath.row]
               
               let createAddonsController = self.storyboard?.instantiateViewController(withIdentifier: ProductConstant.VCreateAddonsController) as! CreateAddonsController
               createAddonsController.addonsData = dict
               self.navigationController?.pushViewController(createAddonsController, animated: true)
    }
}

//MARK:- UITableViewDelegate

extension AddonsListController:  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastCell = (self.addonsArr.count) - 2
        if self.addonsArr.count >= 10 {
            if indexPath.row == lastCell {
                if totalRecord != 0 {
                    self.isUpdate = true
                    offSet = offSet + (self.addonsArr.count)
                    getAddonsList()
                }
            }
        }
    }
    
}


//MARK:- ProductPresenterToProductViewProtocol

extension AddonsListController: ProductPresenterToProductViewProtocol{
    func getAddonsSuccess(addonsEntity: AddonsEntity) {
        self.addonsArr = addonsEntity.responseData?.data ?? []
        self.addonsTableView.reloadData()
        
        if self.isUpdate  {
            if (addonsEntity.responseData?.data?.count ?? 0) > 0
            {
                for i in 0..<(addonsEntity.responseData?.data?.count ?? 0)
                {
                    let dict = addonsEntity.responseData?.data?[i]
                    self.addonsArr.append(dict!)
                }
            }
        }else{
            self.addonsArr = addonsEntity.responseData?.data ?? []
        }
        if self.addonsArr.count == 0 {
            self.addonsTableView.setBackgroundImageAndTitle(imageName: ProductConstant.noAddonsList, title: ProductConstant.noAddonsListEmpty.localized,tintColor: .black)
        }else{
            self.addonsTableView.backgroundView = nil
        }
        totalRecord  = addonsEntity.responseData?.current_page ?? 0
        self.addonsTableView.reloadData()
    }
    func deleteAddonsSuccess(deleteAddonsEntity: CreateAddonsEntity) {
        ToastManager.show(title: deleteAddonsEntity.message ?? "", state: .success)
        getAddonsList()
    }
}

//MARK:- AddOnsListTableViewCellDelegate

extension AddonsListController: AddOnsListTableViewCellDelegate {
    
    func deleteAddons(tagIndex: Int) {
        AppAlert.shared.simpleAlert(view: self, title: "", message: ProductConstant.addonsDelete.localized, buttonOneTitle: Constant.SDelete.localized.capitalizingFirstLetter(), buttonTwoTitle: Constant.SCancel.localized)
        AppAlert.shared.onTapAction = { [weak self] tag in
            guard let self = self else {
                return
            }
            if tag == 0 {
                self.deleteAddonsApiCall(addonsId: self.addonsArr[tagIndex].id ?? 0)
            }
        }
    }
    
    private func deleteAddonsApiCall(addonsId: Int){
        
        productPresenter?.deleteAddons(addonsId: addonsId)
    }
}
