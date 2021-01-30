//
//  ProductListController.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Alamofire

class ProductListController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var addProductButton: UIButton!
    
    var offSet: Int = 0
    var isUpdate = false
    var totalRecord = 0
    var lastPage = 0
    var nextPage = ""
    var currentPage = 1
    var productArr: [ProductData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initalLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addProductButton.setCornerRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isUpdate = false
        currentPage = 1

        getProductList()
    }
    
    private func initalLoad(){
        productTableView.register(nibName: ProductConstant.TAddCategoryTableViewCell)
        self.hideTabBar()
        setNavigationTitle()
        self.view.backgroundColor = .backgroundColor
        productTableView.backgroundColor = .backgroundColor
        self.productTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.addProductButton.frame.height + 10, right: 0)
        addProductButton.setTitle(ProductConstant.addProduct, for: .normal)
        addProductButton.setTitleColor(.white, for: .normal)
        addProductButton.backgroundColor = .appPrimaryColor
        addProductButton.titleLabel?.font = .setCustomFont(name: .bold, size: .x14)
        self.setLeftBarButtonWith(color: .blackColor)
        self.title = ProductConstant.productList.localized
        addProductButton.addTarget(self, action: #selector(TapOnAddProductAction), for: .touchUpInside)
    }
    
    @objc func TapOnAddProductAction() {
        let createCategoryController = self.storyboard?.instantiateViewController(withIdentifier: ProductConstant.VCreateProductController) as! CreateProductController
        self.navigationController?.pushViewController(createCategoryController, animated: true)
    }
    
    private func getProductList() {
        
        productPresenter?.getProductList(id: currentPage.toString(), isShowLoader: isUpdate ? false : true)
    }
}

//MARK:- UITableViewDataSource

extension ProductListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductConstant.TAddCategoryTableViewCell, for: indexPath) as! AddCategoryTableViewCell
        let dict = productArr[indexPath.row]
        cell.setProductData(productData: dict, tagIndex: indexPath.row)
        cell.productDelegate = self
        return cell
    }
}

//MARK:- UITableViewDelegate

extension ProductListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let createCategoryController = self.storyboard?.instantiateViewController(withIdentifier: ProductConstant.VCreateProductController) as! CreateProductController
        createCategoryController.productData = productArr[indexPath.row]
        self.navigationController?.pushViewController(createCategoryController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastCell = (self.productArr.count) - 2
        if indexPath.row == lastCell {
            if self.productArr.count < totalRecord {
                if currentPage < lastPage {
                    currentPage = currentPage + 1
                    
                    self.isUpdate = true
                    getProductList()
                }
            }
        }
    }
}

//MARK:- ProductPresenterToProductViewProtocol

extension ProductListController: ProductPresenterToProductViewProtocol {
    
    func getProductSuccess(getProductEntity: GetProductEntity) {
//        self.productArr = getProductEntity.responseData?.data ?? []
//        self.productTableView.reloadData()
        
        if self.isUpdate  {
            if (getProductEntity.responseData?.data?.count ?? 0) > 0
            {
                for i in 0..<(getProductEntity.responseData?.data?.count ?? 0)
                {
                    let dict = getProductEntity.responseData?.data?[i]
                    self.productArr.append(dict!)
                }
                isUpdate = false
            }
        }else{
            self.productArr.removeAll()
           self.productArr = getProductEntity.responseData?.data ?? []
        }
        if self.productArr.count == 0 {
            self.productTableView.setBackgroundImageAndTitle(imageName: ProductConstant.noAddonsList, title: ProductConstant.noproductsListEmpty.localized,tintColor: .black)
        }else{
            self.productTableView.backgroundView = nil
        }
        totalRecord  = getProductEntity.responseData?.total ?? 0
        lastPage = getProductEntity.responseData?.last_page ?? 0
        nextPage = getProductEntity.responseData?.next_page_url ?? ""
        self.productTableView.reloadData()
    }
    
    func deleteProductSuccess(deleteProductEntity: CreateAddonsEntity) {
        ToastManager.show(title: deleteProductEntity.message ?? "", state: .success)
        isUpdate = false
              currentPage = 1
        getProductList()
    }
}

//MARK:- AddProductTableViewCellDelegate

extension ProductListController: AddProductTableViewCellDelegate {
    
    func deleteProduct(tagIndex: Int) {
        AppAlert.shared.simpleAlert(view: self, title: "", message: ProductConstant.productDelete.localized, buttonOneTitle: Constant.SDelete.localized.capitalizingFirstLetter(), buttonTwoTitle: Constant.SCancel.localized)
               AppAlert.shared.onTapAction = { [weak self] tag in
                   guard let self = self else {
                       return
                   }
                   if tag == 0 {
                       self.deleteProductApiCall(productId: self.productArr[tagIndex].id ?? 0)
                   }
               }
    }
    
    private func deleteProductApiCall(productId: Int){
        
        productPresenter?.deleteProduct(productId: productId)
    }
    
}
