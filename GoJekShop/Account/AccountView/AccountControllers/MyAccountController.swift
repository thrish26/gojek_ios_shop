//
//  MyAccountController.swift
//  GoJekUser
//
//  Created by Ansar on 22/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class MyAccountController: UIViewController {
    
    @IBOutlet weak var accountCollectionView:UICollectionView!
    
    let actionSheet = AppActionSheet.shared
    var accountImageArr = [AccountConstant.edit,
                           AccountConstant.edit_Time,
                           AccountConstant.ic_revenue,
                           AccountConstant.ic_changePwd,AccountConstant.ic_promo]
    
    var accountNameArr = [AppManager.shared.storeType == "FOOD" ? AccountConstant.editRestaurant.localized
        : AccountConstant.editShop.localized,
                          AccountConstant.editTiming.localized,
                          AccountConstant.revenue.localized,
                          AccountConstant.changePassword.localized,AccountConstant.promoCode.localized]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showTabBar()
        self.setLocalization()
        self.accountCollectionView.reloadData()
    }
}

//MARK:- Methods

extension MyAccountController {
    
    private func initialLoads() {
        setNavigationTitle()
        setupLanguage()
        
        self.view.backgroundColor = .backgroundColor
        self.accountCollectionView.backgroundColor = .backgroundColor
        self.accountCollectionView.register(nibName: AccountConstant.AccountCollectionViewCell)
    }
    
    private func setupLanguage() {
        let rightBarButton = UIBarButtonItem(image: UIImage(named: AccountConstant.logoutImage), style: .plain, target: self, action: #selector(tapMore))
        rightBarButton.tintColor = .blackColor
        self.navigationItem.rightBarButtonItem  = rightBarButton
    }
    
    private func push(id:String)  {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: id)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc private func tapMore() {
        actionSheet.showActionSheet(viewController: self,message: AccountConstant.logoutMsg.localized, buttonOne: AccountConstant.logout.localized)
        actionSheet.onTapAction = { [weak self] tag in
            guard let self = self else {
                return
            }
            self.accountPresenter?.toLogout()
        }
    }
    
    private func setLocalization() {
        self.title = AccountConstant.account.localized
    }
}


//MARK:- UICollectionViewDelegate

extension MyAccountController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                self.push(id: AccountConstant.EditRestaurantController)
            case 1:
                self.push(id: AccountConstant.EditTimingController)
            case 2:
                self.push(id: AccountConstant.RevenueController)
            case 3:
                self.push(id: AccountConstant.ChangePasswordController)
            case 4:
                self.push(id: AccountConstant.PromoCodeListViewController)
//                self.push(id: AccountConstant.PromoViewController)
            
            default:
                break
        }
    }
}

//MARK: - UICollectionViewDataSource

extension MyAccountController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.accountNameArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AccountCollectionViewCell = self.accountCollectionView.dequeueReusableCell(withReuseIdentifier: AccountConstant.AccountCollectionViewCell, for: indexPath) as! AccountCollectionViewCell
        cell.setValues(name: accountNameArr[indexPath.item], imageString: accountImageArr[indexPath.item])
        
        cell.layoutIfNeeded()
        
        return cell
    }
}

//MARK:- UICollectionViewDelegateFlowLayout

extension MyAccountController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let width:CGFloat = (self.accountCollectionView.frame.size.width - space) / 2.0
        let height:CGFloat = (self.accountCollectionView.frame.size.width - space) / 2.5
        
        return CGSize(width: width, height: height)
    }
}

//MARK:- AccountPresenterToAccountViewProtocol

extension MyAccountController: AccountPresenterToAccountViewProtocol {
    
    func getLogoutSuccess(logoutEntity: LogoutEntity) {
        BackGroundRequestManager.share.stopBackGroundRequest()
        BackGroundRequestManager.share.resetBackGroudTask()
        AppConfigurationManager.shared.baseConfigModel = nil
        
               PersistentManager.shared.delete(entityName: CoreDataEntity.loginData.rawValue)
               PersistentManager.shared.delete(entityName: CoreDataEntity.userData.rawValue)
        BackGroundRequestManager.share.stopBackGroundRequest()
        AppManager.shared.accessToken = ""
UserDefaults.standard.set(nil, forKey: "AccessToken")

        let walkThrough = LoginRouter.loginStoryboard.instantiateViewController(withIdentifier: LoginConstant.SplashViewController)
        CommonFunction.changeRootController(controller: walkThrough)
    }
}


