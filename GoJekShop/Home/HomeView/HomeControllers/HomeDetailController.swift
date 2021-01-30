//
//  HomeDetailController.swift
//  GoJekShop
//
//  Created by Sudar on 16/12/19.
//  Copyright © 2019 appoets. All rights reserved.
//

import UIKit
import Alamofire

class HomeDetailController: UIViewController {
    
    @IBOutlet weak var homeDetailTableView:UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    var datePicker:UIDatePicker = UIDatePicker()
    let toolBar = UIToolbar()
    var orderType:OrderType = .ordered
    var upcomingRequestData: UpcomingRequestData?
    var phoneNumber:String? = ""
    var selectedDate = String()
    weak var delegate: updatesocketDelegate?
    let cancelReasonTxtVw = UITextView(frame: CGRect.zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initalLoads()
    }
}

extension HomeDetailController {
    
    private func initalLoads() {
        self.homeDetailTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.bottomView.frame.height + 10, right: 0)
        self.title = upcomingRequestData?.store_order_invoice_id
        self.hideTabBar()
        cancelReasonTxtVw.delegate = self
        cancelReasonTxtVw.textColor = .lightGray
        cancelReasonTxtVw.text = HomeConstant.reasonfor
        setNavigationTitle()
        setLeftBarButtonWith(color: .blackColor)
        acceptButton.titleLabel?.font = .setCustomFont(name: .medium, size: .x14)
        cancelButton.titleLabel?.font = .setCustomFont(name: .medium, size: .x14)
        acceptButton.backgroundColor = .appPrimaryColor
        cancelButton.backgroundColor = .appPrimaryColor
        acceptButton.setCornerRadiuswithValue(value: 8)
        cancelButton.setCornerRadiuswithValue(value: 8)
        
        homeDetailTableView.register(nibName: HomeConstant.TItemCell)
        homeDetailTableView.register(nibName: HomeConstant.TUpcomingDetailProfileCell)
        homeDetailTableView.register(nibName: HomeConstant.TDeliveryChargeCell)
        homeDetailTableView.register(nibName: HomeConstant.TDAddonsCell)
        cancelButton.setTitle(Constant.SCancel.uppercased(), for: .normal)
        acceptButton.setTitle(Constant.SAccept.uppercased(), for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        acceptButton.setTitleColor(.white, for: .normal)
        
        cancelButton.titleLabel?.font = .setCustomFont(name: .medium, size: .x16)
        acceptButton.titleLabel?.font = .setCustomFont(name: .medium, size: .x16)
        acceptButton.addTarget(self, action: #selector(tapAcceptButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
        homeDetailTableView.reloadData()
        bottomView.backgroundColor = .backgroundColor
        homeDetailTableView.backgroundColor = .backgroundColor
        hideKeyboardWhenTappedAround()
        
        if orderType == .ordered {
            bottomView.isHidden = false
        }else{
            bottomView.isHidden = true
        }
    }
}

//MARK:- UITableViewDataSource ,UITableViewDelegate


extension HomeDetailController: UITableViewDataSource ,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if section == 0 {
            count = 1
            
        }else if section == 1 {
            count = upcomingRequestData?.invoice?.items?.count ?? 0
        }else if section ==  2{
            count = 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeConstant.TUpcomingDetailProfileCell, for: indexPath) as! UpcomingDetailProfileCell
            
            if let imageUrl = URL(string: upcomingRequestData?.user?.picture ?? ""){
                cell.profileImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: AccountConstant.icprofile))
                
            }else{
                cell.profileImageView.image = UIImage(named: AccountConstant.icprofile)
            }
            let name = (upcomingRequestData?.user?.first_name ?? "") + (upcomingRequestData?.user?.last_name ?? "")
            cell.callButton.addTarget(self, action: #selector(tapCallButton), for: .touchUpInside)
            
            cell.nameLabel.text = name
            phoneNumber = upcomingRequestData?.user?.mobile ?? ""
            
            cell.addressLabel.text = upcomingRequestData?.delivery?.map_address
            cell.paymentLabel.text = upcomingRequestData?.invoice?.payment_mode
            
            return cell
        }else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeConstant.TItemCell, for: indexPath) as! ItemCell
            
            let dict = self.upcomingRequestData?.invoice?.items?[indexPath.row]
            cell.itemNameLabel.text = dict?.product?.item_name
            cell.priceLabel.text = dict?.total_item_price?.setCurrency()
            cell.quantityLabel.text = dict?.quantity?.toString()
            
            let cartDetails = self.getCartAddOnValue(values: dict?.cartaddon ?? [])
            
            cell.addonsNameLabel.text = cartDetails
            
            return cell
        }else if indexPath.section == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeConstant.TDeliveryChargeCell, for: indexPath) as! DeliveryChargeCell
            let dict = self.upcomingRequestData?.invoice
            
            cell.itemPriceValueLabel.text = dict?.item_price?.setCurrency()
            
            cell.storePackageValueLabel.text = (dict?.store_package_amount ?? 0)?.setCurrency()
            if self.upcomingRequestData?.invoice?.promocode_id == 0 {
                cell.couponView.isHidden = true
            }else{
                cell.couponView.isHidden = false
            }
            cell.couponValueLabel.text = "- " + ((dict?.promocode_amount ?? 0)?.setCurrency() ?? String.empty)
            
            cell.deliverychargeValueLabel.text = (dict?.delivery_amount ?? 0)?.setCurrency()
            
            cell.totalValueLabel.text = (self.upcomingRequestData?.invoice?.total_amount ?? 0)?.setCurrency()
            cell.taxValueLabel.text = (self.upcomingRequestData?.invoice?.tax_amount ?? 0)?.setCurrency()
            
            if self.upcomingRequestData?.invoice?.discount == 0 {
                cell.discountView.isHidden = true
            }else{
                cell.discountView.isHidden = false
            }
            cell.discountValueLabel.text = "- " + ((self.upcomingRequestData?.invoice?.discount ?? 0)?.setCurrency() ?? String.empty)
            
            return cell
        }
        return UITableViewCell()
    }
}


extension HomeDetailController {
    
    func getCartAddOnValue(values: [Cartaddon]) -> (String) {
        var cartName:String = ""
        for cart in values {
            cartName = cartName + (cart.addon_name ?? "") + ","
        }
        cartName = String(cartName.dropLast())
        return (cartName)
    }
    
    @objc func tapCallButton() {
        guard let _ = self.phoneNumber else {
            return
        }
        AppUtils.shared.call(to: self.phoneNumber)
    }
    
    @objc func tapCancelButton() {
        cancelReasonTxtVw.text =  HomeConstant.reasonfor
        let alertController = UIAlertController(title: "\(HomeConstant.tellreason)\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
            cancelReasonTxtVw.textColor = .lightGray
           cancelReasonTxtVw.textContainerInset = UIEdgeInsets.init(top: 8, left: 5, bottom: 8, right: 5)
        cancelReasonTxtVw.delegate = self
       // cancelReasonTxtVw.keyboardDistanceFromTextField = 20
        
        let saveAction = UIAlertAction(title: Constant.SOk, style: .default) { [weak alertController] _ in
            guard alertController != nil else { return }
            
           // print("Time \(String(describing: t.text ?? ""))")
            
            if self.cancelReasonTxtVw.text == "" || self.cancelReasonTxtVw.text == HomeConstant.reasonfor {
                ToastManager.show(title: HomeConstant.enterCancel, state: .error)
                
            }else{
                //compare the current password and do action here
                
                

                         let param: Parameters = [HomeConstant.id:self.upcomingRequestData?.id ?? 0,
                                                  HomeConstant.store_id:self.upcomingRequestData?.store_id ?? 0,
                                                HomeConstant.user_id:self.upcomingRequestData?.user_id ?? 0,
                                         HomeConstant.cancel_reason:String(describing: self.cancelReasonTxtVw.text ?? "")
                            ]
                            self.homePresenter?.cancelRequest(param: param)
            }
        }
        
        alertController.addAction(saveAction)
        saveAction.isEnabled = false
        
        alertController.hideKeyboardWhenTappedAround()

    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.view.addObserver(self, forKeyPath: "bounds", options: NSKeyValueObservingOptions.new, context: nil)

        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: cancelReasonTxtVw, queue: OperationQueue.main) { (notification) in
               saveAction.isEnabled = self.cancelReasonTxtVw.text != ""
           }

        cancelReasonTxtVw.backgroundColor = UIColor.white
           alertController.view.addSubview(self.cancelReasonTxtVw)

         
           alertController.addAction(cancelAction)

        
        self.present(alertController, animated: true, completion:{
            alertController.view.superview?.isUserInteractionEnabled = true
             
            self.cancelReasonTxtVw.becomeFirstResponder()
                UIView.animate(withDuration: 0.5, animations: {
                    alertController.view.frame.origin.y = 200
                })
            
            
            alertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
          })
    }
    
    @objc func alertControllerBackgroundTapped() {
        if cancelReasonTxtVw.text == .empty {
                   cancelReasonTxtVw.text = HomeConstant.reasonfor.localized
                   cancelReasonTxtVw.textColor = .lightGray
               }
        self.dismiss(animated: true, completion: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
       if keyPath == "bounds"{
              if let rect = (change?[NSKeyValueChangeKey.newKey] as? NSValue)?.cgRectValue {
                  let margin: CGFloat = 8
                  let xPos = rect.origin.x + margin
                  let yPos = rect.origin.y + 80
                  let width = rect.width - 2 * margin
                  let height: CGFloat = 90

                  cancelReasonTxtVw.frame = CGRect.init(x: xPos, y: yPos, width: width, height: height)
              }
        }
    }
    

    
    func showPicker(){
         
        PickerManager.shared.showDateAndTimePicker(selectedDate: nil) { (data) in
             self.selectedDate = data.replacingOccurrences(of: "-", with: "/")
            print(self.selectedDate)
             let param: Parameters = [HomeConstant.store_order_id:self.upcomingRequestData?.id ?? 0,
                     HomeConstant.cooking_time:String(describing: self.selectedDate),
                     HomeConstant.user_id:self.upcomingRequestData?.user_id ?? 0]
             self.homePresenter?.acceptRequest(param: param)
             }
    }
    
    
    @objc func tapAcceptButton() {

        if AppManager.shared.storeType == "OTHERS" {
    let alertController = UIAlertController(title: HomeConstant.preparationDate, message: "", preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: Constant.select, style: .default) { [weak alertController] _ in
                  self.showPicker()
                }
                alertController.addAction(confirmAction)
                let cancelAction = UIAlertAction(title: Constant.SCancel, style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                present(alertController, animated: true, completion: nil)
        }
        else{
            let alertController = UIAlertController(title: HomeConstant.orderDeliveryTime, message: HomeConstant.preparationTime, preferredStyle: .alert)
                    alertController.addTextField { textField in
                        textField.placeholder = HomeConstant.mins
                        textField.isSecureTextEntry = false
                        textField.keyboardType = .numberPad
            }
            let confirmAction = UIAlertAction(title: Constant.SOk, style: .default) { [weak alertController] _ in
                        guard let alertController = alertController, let textField = alertController.textFields?.first else { return }
            
                        print("Time \(String(describing: textField.text ?? ""))")
            
                        if textField.text == "" {
                            ToastManager.show(title: HomeConstant.enterTime, state: .error)
            
                        }else{
                            //compare the current password and do action here
                            let param: Parameters = [HomeConstant.store_order_id:self.upcomingRequestData?.id ?? 0,
                                                     HomeConstant.cooking_time:String(describing: textField.text ?? ""),
                                                     HomeConstant.user_id:self.upcomingRequestData?.user_id ?? 0]
            
                self.homePresenter?.acceptRequest(param: param)
                }
            }
            alertController.addAction(confirmAction)
                    let cancelAction = UIAlertAction(title: Constant.SCancel, style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
    }
}


//MARK:- HomePresenterToHomeViewProtocol

extension HomeDetailController: HomePresenterToHomeViewProtocol {
    
    func acceptRequestSuccess(acceptRequestEntity: UpcomingRequestEntity) {
        ToastManager.show(title: acceptRequestEntity.message ?? "", state: .success)
        self.dismiss(animated: true, completion: nil)
        delegate?.updateSocket()
        self.navigationController?.popViewController(animated: true)
    }
    
    func cancelRequestSuccess(cancelRequestEntity: UpcomingRequestEntity) {
        DispatchQueue.main.async {
            print("Request cancellled succsfully")
             ToastManager.show(title: cancelRequestEntity.message ?? "", state: .success)
            self.delegate?.updateSocket()
            self.navigationController?.popViewController(animated: true)

        }
    }
}

// MARK: - Protocol
protocol updatesocketDelegate: class {
    func updateSocket()
}
extension HomeDetailController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == HomeConstant.reasonfor.localized {
            textView.text = .empty
            textView.textColor = .black
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text == .empty {
            textView.text = HomeConstant.reasonfor.localized
            textView.textColor = .lightGray
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cancelReasonTxtVw.endEditing(true)
    }
}
extension String {
    //Check sting is empty
       static var Empty: String {
           return ""
       }
}
