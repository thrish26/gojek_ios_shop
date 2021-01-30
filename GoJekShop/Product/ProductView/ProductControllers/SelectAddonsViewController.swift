//
//  SelectAddonsViewController.swift
//  GoJekShop
//
//  Created by Sudar on 11/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit

class SelectAddonsViewController: UIViewController {
    
    @IBOutlet weak var addonsTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveView: UIButton!
    @IBOutlet weak var addonsTitleLabel: UILabel!
    
    var addonsList:[AddonsListResponseData] = []
    
    weak var delegate: SelectAddonsDataDelegate?
    
    var priceArr:NSMutableArray = []
    var IdArr:NSMutableArray = []
    var addonsName:NSMutableArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setInitalLoads()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension SelectAddonsViewController {
    private func setInitalLoads(){
        setFont()
        addonsTableView.register(nibName: ProductConstant.TSelectAddonsTableViewCell)
        saveButton.setTitle(Constant.SSave.localized, for: .normal)
        saveButton.titleLabel?.font = .setCustomFont(name: .bold, size: .x14)
        saveButton.backgroundColor = .appPrimaryColor
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitle(Constant.SSave.localized, for: .normal)
        saveButton.addTarget(self, action: #selector(TapOnSaveAction), for: .touchUpInside)
        if addonsList.isEmpty {
            productPresenter?.getAddons()
        }
        saveButton.setBothCorner()
        addonsTitleLabel.text = ProductConstant.addons.localized
        self.view.backgroundColor = .groupTableViewBackground
        self.addonsTableView.backgroundColor = .white
        addonsTitleLabel.font = .setCustomFont(name: .bold, size: .x16)
        addonsTitleLabel.textColor = .appPrimaryColor
        setNavigationTitle()
        setLeftBarButtonWith(color: .black)
        self.title = ProductConstant.selectAddons.localized
        
    }
    @objc func TapOnSaveAction() {
        delegate?.selectedAddons(id: IdArr, price: priceArr, addonsName: addonsName)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setFont(){
        addonsTitleLabel.font = .setCustomFont(name: .medium, size: .x14)
    }
}
extension SelectAddonsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addonsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductConstant.TSelectAddonsTableViewCell, for: indexPath) as! SelectAddonsTableViewCell
        let dict = addonsList[indexPath.row]
        cell.addonsNameLabel.text = dict.addon_name
        
        cell.priceTextField.tag = indexPath.row
        cell.delegate = self
        
        
        if IdArr.contains(dict.id ?? 0) {
            cell.checkImageView.image = UIImage(named: Constant.circleFullImage)
            cell.priceTextField.text = priceArr[indexPath.row] as? String
        }else{
            cell.checkImageView.image = UIImage(named: Constant.circleImage)
            cell.priceTextField.text = "0"
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = addonsList[indexPath.row]
        let cell = self.addonsTableView.cellForRow(at: indexPath) as! SelectAddonsTableViewCell
        
        if cell.priceTextField.text != "0" {
            
            if dict.storeitem != nil {
                IdArr.replaceObject(at: indexPath.row, with: dict.storeitem?.store_addon_id ?? 0)
                priceArr.replaceObject(at: indexPath.row, with: cell.priceTextField.text ?? String.empty)
            } else {
                IdArr.replaceObject(at: indexPath.row, with: dict.id ?? 0)
                priceArr.replaceObject(at: indexPath.row, with: cell.priceTextField.text ?? String.empty)
            }
            addonsName.replaceObject(at: indexPath.row, with: dict.addon_name ?? String.empty)
            
            self.addonsTableView.reloadData()
        }else{
            ToastManager.show(title: ProductConstant.priceEmpty, state: .error)
            
        }
        
        
    }
}
extension SelectAddonsViewController: ProductPresenterToProductViewProtocol {
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
        addonsTableView.reloadData()
        
    }
}

extension SelectAddonsViewController: SelectAddonsCellDelegate {
    func didSelectTextField(index: Int, textFieldStr: String) {
        let dict = addonsList[index]
        if textFieldStr != "0" {
            IdArr.replaceObject(at: index, with: dict.id ?? 0)
            priceArr.replaceObject(at: index, with: textFieldStr)
            addonsName.replaceObject(at: index, with: dict.addon_name ?? String.empty)
            
            self.addonsTableView.reloadData()
        }else{
            ToastManager.show(title: ProductConstant.priceEmpty, state: .error)
            
        }
    }
    
    
}

protocol SelectAddonsDataDelegate: class {
    
    func selectedAddons(id: NSMutableArray,price: NSMutableArray,addonsName: NSMutableArray)
}
