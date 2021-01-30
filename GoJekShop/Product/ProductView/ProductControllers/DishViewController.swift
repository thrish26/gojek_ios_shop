//
//  DishViewController.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit

class DishViewController: UIViewController {
    
    @IBOutlet weak var dishTableView: UITableView!
    
    var menuTitleArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setInitialLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showTabBar()
        
    }
    
    private func setInitialLoad(){
        self.title = ProductConstant.TDish.localized
        if AppManager.shared.storeType == "OTHERS" {
                  self.title = ProductConstant.TItems.localized
                  self.menuTitleArr = [
                  ProductConstant.TCategory,
                  ProductConstant.TProduct]
              }else{
              self.title = ProductConstant.TDish.localized
                  self.menuTitleArr = [ProductConstant.TAddons,
                  ProductConstant.TCategory,
                  ProductConstant.TProduct]
              }
        dishTableView.register(nibName: ProductConstant.TDishTableViewCell)
        dishTableView.reloadData()
        showTabBar()
        setNavigationTitle()
        self.dishTableView.backgroundColor = .backgroundColor
        self.view.backgroundColor = .backgroundColor
        self.tabBarItem.title = ProductConstant.TProduct.localized
    }
}

//MARK:- UITableViewDataSource

extension DishViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductConstant.TDishTableViewCell, for: indexPath) as! DishTableViewCell
        
        cell.titleLabel.text = menuTitleArr[indexPath.row].uppercased()
        
        return cell
    }
}

//MARK:- UITableViewDataSource

extension DishViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if menuTitleArr[indexPath.row] == ProductConstant.TAddons {
            let addonsListController = self.storyboard?.instantiateViewController(withIdentifier: ProductConstant.VAddonsListController) as! AddonsListController
            self.navigationController?.pushViewController(addonsListController, animated: true)
        }else if menuTitleArr[indexPath.row] == ProductConstant.TCategory {
            let categoryListController = self.storyboard?.instantiateViewController(withIdentifier: ProductConstant.VCategoryListController) as! CategoryListController
            self.navigationController?.pushViewController(categoryListController, animated: true)
        }else {
            let productListController = self.storyboard?.instantiateViewController(withIdentifier: ProductConstant.VProductListController) as! ProductListController
            self.navigationController?.pushViewController(productListController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

//MARK:- ProductPresenterToProductViewProtocol

extension DishViewController: ProductPresenterToProductViewProtocol {
    
}
