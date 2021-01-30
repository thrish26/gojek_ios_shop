//
//  CustomTableViewController.swift
//  GoJekShop
//
//  Created by Sudar on 04/03/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit

class CuisineTableViewController: UIViewController {
    
    @IBOutlet weak var cuisineTableView:UITableView!
    @IBOutlet weak var saveButton:UIButton!
    @IBOutlet weak var saveView:UIView!
    
    var cuisineData:[Cuisine_data] = []
    var selectedCuisineData: [Cuisine_data] = []
    
    weak var delegate: SelectCuisineDelegate?

    
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
        cuisineTableView.register(nibName: AccountConstant.TCuisineTableViewCell)
        self.hideTabBar()
        self.title = AccountConstant.selectCuisine.localized
        cuisineTableView.reloadData()
        setNavigationTitle()
        setLeftBarButtonWith(color: .blackColor)
        self.cuisineTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.saveView.frame.height + 10, right: 0)
        saveButton.setTitle(Constant.SSave.localized, for: .normal)
        saveButton.titleLabel?.font = .setCustomFont(name: .bold, size: .x14)
        saveButton.backgroundColor = .appPrimaryColor
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitle(Constant.SSave.localized, for: .normal)
        
        saveButton.addTarget(self, action: #selector(TapOnSaveAction), for: .touchUpInside)
    }
    
    @objc func TapOnSaveAction() {
        delegate?.didSelectCuisine(data: selectedCuisineData)
        self.navigationController?.popViewController(animated: true)
    }
}

extension CuisineTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cuisineData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cuisineTableViewCell = tableView.dequeueReusableCell(withIdentifier: AccountConstant.TCuisineTableViewCell, for: indexPath) as! CuisineTableViewCell
        let dict = cuisineData[indexPath.row]
        
        cuisineTableViewCell.titleLabel.text = dict.name
        if selectedCuisineData.contains(where: { $0.id == dict.id }) {
            cuisineTableViewCell.checkImageView.image = UIImage(named: Constant.circleFullImage)
        }else{
            cuisineTableViewCell.checkImageView.image = UIImage(named: Constant.circleImage)
        }
    cuisineTableViewCell.checkImageView.imageTintColor(color1: .blackColor)
        return cuisineTableViewCell
    }
}

//MARK:- UITableViewDelegate

extension CuisineTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = cuisineData[indexPath.row]
        
        if let index = selectedCuisineData.firstIndex(where: { $0.id == dict.id }) {
            selectedCuisineData.remove(at: index)
        }else{
            self.selectedCuisineData.append(dict)
        }
        self.cuisineTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

//MARK:- SelectCuisineDelegate

protocol SelectCuisineDelegate : class {
    func didSelectCuisine(data: [Cuisine_data])
}

