//
//  CategoryListController.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Alamofire

class CategoryListController: UIViewController {
    
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var addCategoryButton: UIButton!
    
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addCategoryButton.setCornerRadius()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        offSet = 0
         isUpdate = false
         totalRecord = 0
        getCategoryList()
        
    }
    
    private func initalLoad(){
        categoryTableView.register(nibName: ProductConstant.TAddCategoryTableViewCell)
        self.hideTabBar()
        self.view.backgroundColor = .backgroundColor
        categoryTableView.backgroundColor = .backgroundColor
        self.categoryTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.addCategoryButton.frame.height + 10, right: 0)
        addCategoryButton.setTitle(ProductConstant.addCategory, for: .normal)
        addCategoryButton.setTitleColor(.white, for: .normal)
        addCategoryButton.backgroundColor = .appPrimaryColor
        addCategoryButton.titleLabel?.font = .setCustomFont(name: .bold, size: .x14)
        self.setLeftBarButtonWith(color: .blackColor)
        setNavigationTitle()
        self.title = ProductConstant.categoryList.localized
        addCategoryButton.addTarget(self, action: #selector(TapOnAddCategoryAction), for: .touchUpInside)
        
    }
    private func getCategoryList() {
        let parameter: Parameters = [
            ProductConstant.PLimit:10,
            ProductConstant.POffset:offSet
        ]
        productPresenter?.getCategory(param: parameter, isShowLoader: isUpdate ? false : true)
     
    }
    
    @objc func TapOnAddCategoryAction() {
        let createCategoryController = self.storyboard?.instantiateViewController(withIdentifier: ProductConstant.VCreateCategoryController) as! CreateCategoryController
        self.navigationController?.pushViewController(createCategoryController, animated: true)
    }
    
}
extension CategoryListController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = categoryArr[indexPath.row]
        
        let createCategoryController = self.storyboard?.instantiateViewController(withIdentifier: ProductConstant.VCreateCategoryController) as! CreateCategoryController
        createCategoryController.categoryData = dict
        self.navigationController?.pushViewController(createCategoryController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
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
        cell.categoryDelegate = self
        return cell
    }
    
}
extension CategoryListController: ProductPresenterToProductViewProtocol {
    func getCategorySuccess(getCategoryEntity: GetCategoryEntity) {
        self.categoryArr = getCategoryEntity.responseData?.data ?? []
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
            self.categoryArr = getCategoryEntity.responseData?.data ?? []
        }
        if self.categoryArr.count == 0 {
            self.categoryTableView.setBackgroundImageAndTitle(imageName: ProductConstant.noAddonsList, title: ProductConstant.noCategoryListEmpty.localized,tintColor: .black)
        }else{
            self.categoryTableView.backgroundView = nil
        }
        totalRecord  = getCategoryEntity.responseData?.current_page ?? 0
        self.categoryTableView.reloadData()
        
    }
    
    func deleteCategorySuccess(deleteCategoryEntity: CreateAddonsEntity) {
        ToastManager.show(title: deleteCategoryEntity.message ?? "", state: .success)
        offSet = 0
               isUpdate = false
               totalRecord = 0
          getCategoryList() 
    }
    
    private func deleteCategoryApiCall(categoryId: Int){
        
        productPresenter?.deleteCategory(categoryId: categoryId)
        
    }
}
extension CategoryListController: AddCategoryTableViewCellDelegate{
    func deleteCategory(tagIndex: Int) {
        AppAlert.shared.simpleAlert(view: self, title: "", message: ProductConstant.categoryDelete.localized, buttonOneTitle: Constant.SDelete.localized.capitalizingFirstLetter(), buttonTwoTitle: Constant.SCancel.localized)
        AppAlert.shared.onTapAction = { [weak self] tag in
            guard let self = self else {
                return
            }
            if tag == 0 {
                self.deleteCategoryApiCall(categoryId: self.categoryArr[tagIndex].id ?? 0)
            }
        }
    }
    
    
}
