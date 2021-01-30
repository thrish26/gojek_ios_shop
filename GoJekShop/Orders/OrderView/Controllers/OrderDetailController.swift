//
//  OrderDetailController.swift
//  GoJekShop
//
//  Created by Sudar on 27/12/19.
//  Copyright © 2019 appoets. All rights reserved.
//

import UIKit
import Alamofire

class OrderDetailController: UIViewController {
    
    @IBOutlet weak var orderDetailTableView: UITableView!
    
    var historyData:HistoryData?
  //  var orderImageArr = [OrderConstant.ic_desktop,OrderConstant.ic_security,OrderConstant.ic_payment,OrderConstant.ic_discount,OrderConstant.ic_truck]
       var orderImageArr = [OrderConstant.ic_desktop,OrderConstant.ic_security]
    var orderImgArr = [OrderConstant.ic_desktop,Constant.ic_error]
    
    var orderpArr = [OrderConstant.orderPlaced,OrderConstant.orderCancel]
    var orderInfopArr = [OrderConstant.orderPlacedInfo,""]
//    var orderArr = [OrderConstant.orderPlaced,OrderConstant.orderConfirmed,OrderConstant.orderProcessed,OrderConstant.orderPickup,OrderConstant.orderDelivered]
//    var orderInfoArr = [OrderConstant.orderPlacedInfo,OrderConstant.orderConfirmedInfo,OrderConstant.orderProcessedInfo,OrderConstant.orderPickupInfo,OrderConstant.orderDeliveredInfo]
    var orderArr = [OrderConstant.orderPlaced,OrderConstant.orderConfirmed]
       var orderInfoArr = [OrderConstant.orderPlacedInfo,OrderConstant.orderConfirmedInfo]
    
    var orderId = 0
    var historyType:historyType = .ongoing
    
    var isTakeaway:Bool = false {
        didSet {
            
            let istakeAway = isTakeaway
            if istakeAway == true {
//                orderArr = [OrderConstant.orderPlaced,OrderConstant.orderConfirmed,OrderConstant.orderProcessed,OrderConstant.orderDelivered]
//                     orderInfoArr = [OrderConstant.orderPlacedInfo,OrderConstant.orderConfirmedInfo,OrderConstant.orderDeliveredInfo]
//               orderImageArr = [OrderConstant.ic_desktop,OrderConstant.ic_security,OrderConstant.ic_truck]
                
                   orderArr = [OrderConstant.orderPlaced,OrderConstant.orderConfirmed]
                                     orderInfoArr = [OrderConstant.orderPlacedInfo,OrderConstant.orderConfirmedInfo]
                               orderImageArr = [OrderConstant.ic_desktop,OrderConstant.ic_security]
            }else{
//    orderArr = [OrderConstant.orderPlaced,OrderConstant.orderConfirmed,OrderConstant.orderProcessed,OrderConstant.orderPickup,OrderConstant.orderDelivered]
//               orderImageArr = [OrderConstant.ic_desktop,OrderConstant.ic_security,OrderConstant.ic_payment,OrderConstant.ic_discount,OrderConstant.ic_truck]
//         orderInfoArr = [OrderConstant.orderPlacedInfo,OrderConstant.orderConfirmedInfo,OrderConstant.orderProcessedInfo,OrderConstant.orderPickupInfo,OrderConstant.orderDeliveredInfo]
                orderArr = [OrderConstant.orderPlaced,OrderConstant.orderConfirmed]
                             orderImageArr = [OrderConstant.ic_desktop,OrderConstant.ic_security]
                       orderInfoArr = [OrderConstant.orderPlacedInfo,OrderConstant.orderConfirmedInfo]
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initalLoads()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    private func initalLoads(){
        self.ordersPresenter?.getHistoryDetailList(id: orderId)
        orderDetailTableView.backgroundColor = .backgroundColor
        self.view.backgroundColor = .backgroundColor
        orderDetailTableView.register(nibName: HomeConstant.TItemCell)
        orderDetailTableView.register(nibName: OrderConstant.TOrderStatusCell)
        orderDetailTableView.register(nibName: OrderConstant.TOrderListCell)
        orderDetailTableView.register(nibName: HomeConstant.TDeliveryChargeCell)
        setNavigationTitle()
        setLeftBarButtonWith(color: .blackColor)
        hideTabBar()
    }
    @objc func TakeawayAction(sender: UIButton!) {
    
        var params: Parameters
        
        params = ["store_id":historyData?.store_id ?? 0,
                  "user_id":historyData?.user_id ?? 0,
                  "id":historyData?.id ?? 0]
        self.ordersPresenter?.OrdertakeawayPickedup(param: params)
    }
    @objc func AddCancelReason(){
        let footerView:UILabel = UILabel(frame: CGRect(x:30, y: 0, width:orderDetailTableView.frame.size.width-60 , height: 500))
        footerView.text = "Cancel Reason : \(historyData?.reason ?? "")"
        footerView.font = .setCustomFont(name: .medium, size: .x14)
           footerView.numberOfLines = 0;
           footerView.sizeToFit()
        orderDetailTableView.tableFooterView = footerView
        orderDetailTableView.contentInset = (UIEdgeInsets(top: 0, left: 8, bottom: -footerView.frame.size.height, right: 8))
        
    }
    
}
//MARK: - UITableViewDataSource
extension OrderDetailController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
         if historyType == .ongoing {
        if historyData?.order_type == "TAKEAWAY" {
          //  if historyData?.
            guard section == 3 else { return nil }
           
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50.0))
            let takeAwayButton = UIButton(frame: CGRect(x: 20, y: 0, width: footerView.frame.width-40, height: 50.0))
            takeAwayButton.center = footerView.center
             if historyData?.status == "PICKEDUP" {
                takeAwayButton.setTitle(OrderConstant.takeaway, for: .normal)
             }else{
               takeAwayButton.setTitle(OrderConstant.orderReady, for: .normal)
            }
            takeAwayButton.setTitleColor(.white, for: .normal)
            takeAwayButton.backgroundColor = .appPrimaryColor
            takeAwayButton.layer.cornerRadius = 10.0
            takeAwayButton.titleLabel?.font = .setCustomFont(name: .bold, size: .x14)
            takeAwayButton.addTarget(self, action: #selector(TakeawayAction(sender:)), for: .touchUpInside)
            footerView.addSubview(takeAwayButton)
            footerView.backgroundColor = .backgroundColor
            return footerView
            
        }
        }
        let view = UIView()
        view.backgroundColor = .backgroundColor
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        if section == 0 {
            if historyType == .ongoing {
                count = orderImageArr.count
            }else if historyType == .past {
                count = orderImageArr.count
            }else if historyType == .cancelled {
                count = orderImgArr.count
            }
            
        }else if section == 1 {
            count = 1
        }else if section == 2 {
            count = historyData?.order_invoice?.items?.count ?? 0
        }else if section == 3 {
               count = 1
        }
         return count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = self.orderDetailTableView.dequeueReusableCell(withIdentifier: OrderConstant.TOrderStatusCell, for: indexPath) as! OrderStatusCell
            if historyType == .ongoing {
            
                cell.orderImageView.image = UIImage(named: orderImageArr[indexPath.row])
                cell.orderNameLabel.text = orderArr[indexPath.row]
                cell.orderNameInfoLabel.text = orderInfoArr[indexPath.row]
               if orderArr[indexPath.row] == OrderConstant.orderConfirmed {
                cell.orderdateLabel.text = historyData?.created_time ?? ""
                cell.orderdateLabel.textColor = .blackColor
               }
                if orderArr[indexPath.row] != OrderConstant.orderPlaced {
                    cell.orderNameLabel.textColor = .blackColor
                    cell.orderNameInfoLabel.textColor = UIColor.lightGray
                    cell.orderImageView.alpha = 1.0
                    cell.topView.isHidden = true
                }else{
                    cell.topView.isHidden = false
                    cell.orderNameInfoLabel.textColor = UIColor.lightGray.withAlphaComponent(0.3)
                    cell.orderNameLabel.textColor = UIColor.black.withAlphaComponent(0.3)
                    cell.orderImageView.alpha = 0.5
                }
                
            }else if historyType == .past {
                cell.orderImageView.image = UIImage(named: orderImageArr[indexPath.row])
                cell.orderNameLabel.text = orderArr[indexPath.row]
                cell.orderNameInfoLabel.text = orderInfoArr[indexPath.row]
                if orderArr[indexPath.row] == OrderConstant.orderConfirmed {
                 cell.orderdateLabel.text = historyData?.created_time ?? ""
                 cell.orderdateLabel.textColor = .lightGray
                }
                if orderArr[indexPath.row] == OrderConstant.orderConfirmed {
                    cell.orderNameLabel.textColor = .blackColor
                    cell.orderNameInfoLabel.textColor = UIColor.lightGray
                    cell.orderImageView.alpha = 1.0
                    cell.bottomView.isHidden = true
                }else{
                    cell.bottomView.isHidden = false
                    cell.orderNameInfoLabel.textColor = UIColor.lightGray.withAlphaComponent(0.3)
                    cell.orderNameLabel.textColor = UIColor.black.withAlphaComponent(0.3)
                    cell.orderImageView.alpha = 0.5
                }
                
            }else if historyType == .cancelled {
                cell.orderImageView.image = UIImage(named: orderImgArr[indexPath.row])
                cell.orderNameLabel.text = orderpArr[indexPath.row]
                AddCancelReason()
                cell.orderNameInfoLabel.text = orderInfopArr[indexPath.row]
                if cell.orderNameInfoLabel.text == "" {
                  //  cell.orderImageView.imageTintColor(color1: .appPrimaryColor)
                    cell.orderNameLabel.textColor = .appPrimaryColor
                    cell.orderNameInfoLabel.isHidden = true
                    cell.bottomView.isHidden = true
                    cell.topView.isHidden = false
                    cell.orderNameLabel.text =  (cell.orderNameLabel.text ?? "") + " on " + (historyData?.created_time ?? "")
                    
                }else{
                    cell.topView.isHidden = true
                    cell.orderImageView.imageTintColor(color1: .blackColor)
                    cell.orderNameLabel.textColor = .blackColor
                    cell.orderNameInfoLabel.textColor = .lightGray
                    cell.orderNameInfoLabel.isHidden = false
                    cell.bottomView.isHidden = false
                }
                
            }
            if ((historyType == .cancelled) && (cell.orderNameInfoLabel.text == "")){
                
            }
            else{
                cell.orderImageView.imageTintColor(color1: .blackColor)
                cell.orderNameLabel.textColor = .blackColor
            }
            return cell
            
        }else if indexPath.section == 1 {
            let cell = self.orderDetailTableView.dequeueReusableCell(withIdentifier: OrderConstant.TOrderListCell, for: indexPath) as! OrderListCell
            return cell
            
        }else if indexPath.section == 2{
            let cell = orderDetailTableView.dequeueReusableCell(withIdentifier: HomeConstant.TItemCell, for: indexPath) as! ItemCell
            
            let dict = historyData?.order_invoice?.items?[indexPath.row]
            cell.itemNameLabel.text = dict?.product?.item_name
            cell.priceLabel.text = dict?.total_item_price?.setCurrency()
            cell.quantityLabel.text = dict?.quantity?.toString()
            let cartDetails = self.getCartAddOnValue(values: dict?.cartaddon ?? [])
            cell.addonsNameLabel.text = cartDetails
            
            return cell
            
        }else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeConstant.TDeliveryChargeCell, for: indexPath) as! DeliveryChargeCell
            let dict = historyData?.order_invoice

            cell.itemPriceValueLabel.text = dict?.item_price?.setCurrency()
            cell.storePackageValueLabel.text = (dict?.store_package_amount ?? 0)?.setCurrency()
            if dict?.promocode_id == 0 {
                cell.couponView.isHidden = true
            }else{
                cell.couponView.isHidden = false
            }
            cell.couponValueLabel.text = "- " + ((dict?.promocode_amount ?? 0)?.setCurrency() ?? String.empty)
            
            cell.deliverychargeValueLabel.text = (dict?.delivery_amount ?? 0)?.setCurrency()
            
            cell.totalValueLabel.text = (dict?.total_amount ?? 0)?.setCurrency()
            cell.taxValueLabel.text = (dict?.tax_amount ?? 0)?.setCurrency()
            
            if dict?.discount == 0 {
                cell.discountView.isHidden = true
            }else{
                cell.discountView.isHidden = false
            }
            cell.discountValueLabel.text = "- " + ((dict?.discount ?? 0)?.setCurrency() ?? String.empty)
             return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3{
            return 80
        }
        return 0
    }
    func getCartAddOnValue(values: [Cartaddon]) -> (String) {
              var cartName:String = ""
              for cart in values {
               cartName = cartName + (cart.addon_name ?? "") + ","
              }
              cartName = String(cartName.dropLast())
              return (cartName)
          }
        
}

//MARK: - UITableViewDelegate
extension OrderDetailController: UITableViewDelegate {
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//  
}
extension OrderDetailController: OrderPresenterToOrderViewProtocol{
    
    func getHistoryDetail(historyDetailEntity: HistoryDetailEntity) {
        historyData = historyDetailEntity.responseData
        if historyData?.order_type == "TAKEAWAY" {
                 isTakeaway = true
             }else{
                 isTakeaway = false
             }
        self.title = historyDetailEntity.responseData?.store_order_invoice_id
        orderDetailTableView.reloadData()
    }
    func OrdertakeawayPickedup(takeAwayPickedupEntity: TakeAwayPickedupEntity) {
        if historyData?.status == "PICKEDUP" {
            ToastManager.show(title: takeAwayPickedupEntity.message ?? "" , state: .success)
            self.navigationController?.popViewController(animated: true)
        }else{
            ToastManager.show(title: takeAwayPickedupEntity.message ?? "" , state: .success)
            self.ordersPresenter?.getHistoryDetailList(id: orderId)

        }
    }
}
