//
//  PromoCodeListViewController.swift
//  GoJekShop
//
//  Created by JeyaPrakash on 06/11/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit

class PromoCodeListViewController: UIViewController {

        @IBOutlet weak var promoTableView: UITableView!
        @IBOutlet weak var addPromoButton: UIButton!
        
        var offSet: Int = 0
        var isUpdate = false
        var totalRecord = 0
        var lastPage = 0
        var nextPage = ""
        var currentPage = 1
        var promoArr: [PromoCodeData] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
            initalLoad()
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            addPromoButton.setCornerRadius()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            isUpdate = false
            currentPage = 1

            getPromoList()
        }
        
        private func initalLoad(){
            promoTableView.register(nibName: ProductConstant.PromoCell)
            self.hideTabBar()
            setNavigationTitle()
            self.view.backgroundColor = .backgroundColor
            promoTableView.backgroundColor = .backgroundColor
            promoTableView.delegate = self
            promoTableView.dataSource = self
            self.promoTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.addPromoButton.frame.height + 10, right: 0)
            addPromoButton.setTitle(Constant.addPromo, for: .normal)
            addPromoButton.setTitleColor(.white, for: .normal)
            addPromoButton.backgroundColor = .appPrimaryColor
            addPromoButton.titleLabel?.font = .setCustomFont(name: .bold, size: .x14)
            self.setLeftBarButtonWith(color: .blackColor)
            self.title = ProductConstant.productList.localized
            addPromoButton.addTarget(self, action: #selector(TapOnAddProductAction), for: .touchUpInside)
            
        }
        
        @objc func TapOnAddProductAction() {
        let PromoViewController = self.storyboard?.instantiateViewController(withIdentifier: AccountConstant.PromoViewController) as! PromoViewController
            //            PromoViewController.productData = promoArr[indexPath.row]
        PromoViewController.isEdit = false
        self.navigationController?.pushViewController(PromoViewController, animated: true)
        }
        
        private func getPromoList() {
            
            accountPresenter?.getPromoList(id: currentPage.toString(), isShowLoader: isUpdate ? false : true)
        }
    }

    //MARK:- UITableViewDataSource

    extension PromoCodeListViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return promoArr.count
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductConstant.PromoCell, for: indexPath) as! PromoCell
            let dict = promoArr[indexPath.row]
            cell.setPromoData(promoData: dict, tagIndex: indexPath.row)
            cell.productDelegate = self
            return cell
        }
    }

    //MARK:- UITableViewDelegate

    extension PromoCodeListViewController: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let PromoViewController = self.storyboard?.instantiateViewController(withIdentifier: AccountConstant.PromoViewController) as! PromoViewController
            PromoViewController.promoCodeId = promoArr[indexPath.row].id ?? 0
            PromoViewController.productData = promoArr[indexPath.row]
            PromoViewController.isEdit = true
            self.navigationController?.pushViewController(PromoViewController, animated: true)
        }
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            let lastCell = (self.promoArr.count) - 2
            if indexPath.row == lastCell {
                if self.promoArr.count < totalRecord {
                    if currentPage < lastPage {
                        currentPage = currentPage + 1
                        
                        self.isUpdate = true
                        getPromoList()
                    }
                }
            }
        }
    }

    //MARK:- ProductPresenterToProductViewProtocol

    extension PromoCodeListViewController: AccountPresenterToAccountViewProtocol {
        
        func getPromoSuccess(getPromoCodeEntity: GetPromoCodeEntity) {
//            self.promoArr = getPromoCodeEntity.responseData?.data ?? []
//            self.promoTableView.reloadData()
            
            if self.isUpdate  {
                if (getPromoCodeEntity.responseData?.data?.count ?? 0) > 0
                {
                    for i in 0..<(getPromoCodeEntity.responseData?.data?.count ?? 0)
                    {
                        let dict = getPromoCodeEntity.responseData?.data?[i]
                        self.promoArr.append(dict!)
                    }
                    isUpdate = false
                }
            }else{
                self.promoArr.removeAll()
               self.promoArr = getPromoCodeEntity.responseData?.data ?? []
            }
            if self.promoArr.count == 0 {
                self.promoTableView.setBackgroundImageAndTitle(imageName: ProductConstant.noAddonsList, title: ProductConstant.noproductsListEmpty.localized,tintColor: .black)
            }else{
                self.promoTableView.backgroundView = nil
            }
            totalRecord  = getPromoCodeEntity.responseData?.total ?? 0
            lastPage = getPromoCodeEntity.responseData?.last_page ?? 0
            nextPage = getPromoCodeEntity.responseData?.next_page_url ?? ""
            self.promoTableView.reloadData()
        }
        
        func deletePromoSuccess(deletePromoEntity: CreateAddonsEntity) {
            ToastManager.show(title: deletePromoEntity.message ?? "", state: .success)
            isUpdate = false
                  currentPage = 1
            getPromoList()
        }
    }

    //MARK:- AddProductTableViewCellDelegate

    extension PromoCodeListViewController: AddProductTableViewCellDelegate {
        
        func deleteProduct(tagIndex: Int) {
            AppAlert.shared.simpleAlert(view: self, title: "", message: ProductConstant.promoDelete.localized, buttonOneTitle: Constant.SDelete.localized.capitalizingFirstLetter(), buttonTwoTitle: Constant.SCancel.localized)
                   AppAlert.shared.onTapAction = { [weak self] tag in
                       guard let self = self else {
                           return
                       }
                       if tag == 0 {
                           self.deleteProductApiCall(productId: self.promoArr[tagIndex].id ?? 0)
                       }
                   }
        }
        
        private func deleteProductApiCall(productId: Int){
            
            accountPresenter?.deletePromo(promoId: productId)
        }
        
    }
