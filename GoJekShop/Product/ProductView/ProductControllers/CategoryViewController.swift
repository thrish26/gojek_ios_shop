//
//  CategoryViewController.swift
//  GoJekShop
//
//  Created by Sudar on 24/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Alamofire

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    
    var categoryArr : [CategoryData] = []
    var offSet: Int = 0
    var isUpdate = false
    var totalRecord = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initalLoad()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    private func initalLoad(){
        categoryTableView.register(nibName: ProductConstant.TAddCategoryTableViewCell)
        self.hideTabBar()
        self.view.backgroundColor = .backgroundColor
        categoryTableView.backgroundColor = .backgroundColor
        setNavigationTitle()
        self.setLeftBarButtonWith(color: .blackColor)
        self.title = ProductConstant.categoryList.localized
        setNavigationTitle()
        getCategoryList()
    }
    private func getCategoryList() {
        let parameter: Parameters = [
            ProductConstant.PLimit:10,
            ProductConstant.POffset:offSet
        ]
        productPresenter?.getCategory(param: parameter, isShowLoader: isUpdate ? false : true)
    }
    
}
extension CategoryViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = categoryArr[indexPath.row]
        
        
        for vc in self.navigationController?.viewControllers ?? [UIViewController()] {
            if let myViewCont = vc as? CreateProductController
            {
                myViewCont.categoryData = dict
                myViewCont.category_id = dict.id ?? 0
                self.navigationController?.popToViewController(myViewCont, animated: true)
            }
        }
    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 115
//    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastCell = (self.categoryArr.count) - 2
        if self.categoryArr.count >= 10 {
            if indexPath.row == lastCell {
                if totalRecord != 0 {
                    self.isUpdate = true
                    offSet = offSet + (self.categoryArr.count)
                    getCategoryList()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductConstant.TAddCategoryTableViewCell, for: indexPath) as! AddCategoryTableViewCell
        let dict = categoryArr[indexPath.row]
        cell.setCategoryData(categoryData: dict, tagIndex: indexPath.row)
        cell.deleteButton.isHidden = true
        return cell
    }
    
}
extension CategoryViewController : ProductPresenterToProductViewProtocol {
    func getCategorySuccess(getCategoryEntity: GetCategoryEntity) {
           for i in 0..<(getCategoryEntity.responseData?.data?.count ?? 0)
                        {
                           if getCategoryEntity.responseData?.data?[i].store_category_status == 1{
                            let dict = getCategoryEntity.responseData?.data?[i]
                            self.categoryArr.append(dict!)
                        }
           }
        self.categoryTableView.reloadData()
        
        if self.isUpdate  {
            if (getCategoryEntity.responseData?.data?.count ?? 0) > 0
            {
                for i in 0..<(getCategoryEntity.responseData?.data?.count ?? 0)
                {
                    let dict = getCategoryEntity.responseData?.data?[i]
                    self.categoryArr.append(dict!)
                }
            }
        }else{
            //self.categoryArr = getCategoryEntity.responseData?.data ?? []
        }
        if self.categoryArr.count == 0 {
            self.categoryTableView.setBackgroundImageAndTitle(imageName: ProductConstant.noAddonsList, title: ProductConstant.noCategoryListEmpty.localized,tintColor: .black)
        }else{
            self.categoryTableView.backgroundView = nil
        }
        totalRecord  = getCategoryEntity.responseData?.current_page ?? 0
        self.categoryTableView.reloadData()
        
    }
    
}
