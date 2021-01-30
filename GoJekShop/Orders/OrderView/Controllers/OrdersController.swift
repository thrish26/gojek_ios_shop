//
//  OrdersController.swift
//  GoJekUser
//
//  Created by CSS01 on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire

class OrdersController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var ordersTableView: UITableView!
    @IBOutlet weak var pastOrderButton: UIButton!
    @IBOutlet weak var cancelOrderButton: UIButton!
    @IBOutlet weak var ongoingOrderButton: UIButton!
    
    
    var cellHeights: [IndexPath : CGFloat] = [:]
    var isUpdate = false
    var nextpageurl = ""
    var currentPage = 1
    var historyData = [Historydata]()

    var historyType:historyType = .ongoing {
        didSet {
            updateUI()
        }
    }
    
    // View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        addNavigationTitle()
        self.setLocalization()
        currentPage = 1
        isUpdate = false
        self.ordersPresenter?.getHistoryList(isHideLoader: true, page: currentPage, type: historyType.currentType)
        showTabBar()
        
    }
}

//MARK: - LocalMethod
extension OrdersController {
    
    func initialLoad() {
        setNavigationTitle()
        self.ordersTableView.register(nibName: OrderConstant.VOrderTableViewCell)
        historyType = .ongoing
        self.ordersTableView.backgroundColor = .backgroundColor
        self.view.backgroundColor = .backgroundColor
        ordersTableView.contentInsetAdjustmentBehavior = .never
    }
    
    private func addNavigationTitle(){
        self.title = OrderConstant.history
    }
    
    private func setLocalization() {
        self.pastOrderButton.setTitle(OrderConstant.pastOrder.localized, for: .normal)
        self.cancelOrderButton.setTitle(OrderConstant.cancelOrder.localized, for: .normal)
        self.ongoingOrderButton.setTitle(OrderConstant.ongoingOrder.localized, for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pastOrderButton.setBothCorner()
        cancelOrderButton.setBothCorner()
        ongoingOrderButton.setBothCorner()
    }
    
    private func updateUI() {
        let cancelColor = historyType == .cancelled ? UIColor.appPrimaryColor : UIColor.white
        let pastColor = historyType == .past ? UIColor.appPrimaryColor : UIColor.white
        let ongoingColor = historyType == .ongoing ? UIColor.appPrimaryColor : UIColor.white
        let cancelTextColor = historyType == .cancelled ? UIColor.white : UIColor.black
        let pastTextColor = historyType == .past ? UIColor.white : UIColor.black
        let ongoingTextColor = historyType == .ongoing ? UIColor.white : UIColor.black
        cancelOrderButton.setBorderwithColor(borderColor: cancelColor, textColor: cancelTextColor, backGroundColor: cancelColor, borderWidth: 1)
        pastOrderButton.setBorderwithColor(borderColor: pastColor, textColor: pastTextColor, backGroundColor: pastColor, borderWidth: 1)
        ongoingOrderButton.setBorderwithColor(borderColor: ongoingColor, textColor: ongoingTextColor, backGroundColor: ongoingColor, borderWidth: 1)
    }
    
    private func getOrderHistory(isloader: Bool) {
        self.ordersPresenter?.getHistoryList(isHideLoader: isloader, page: currentPage, type: historyType.currentType)
    }
}

//MARK:- Actions

extension OrdersController {
    
    @IBAction func pastOrderButtonAction(_ sender: Any) {
        historyType = .past
        currentPage = 1
        isUpdate = false
        getOrderHistory(isloader: true)
    }
    
    @IBAction func cancelOrderButtonAction(_ sender: Any) {
        historyType = .cancelled
        currentPage = 1
        isUpdate = false
        getOrderHistory(isloader: true)
     
    }
    
    @IBAction func ongoingOrderButton(_ sender: Any) {
        historyType = .ongoing
        currentPage = 1
        isUpdate = false
        getOrderHistory(isloader: true)
    }
    
}

//MARK: - UITableViewDataSource
extension OrdersController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.ordersTableView.dequeueReusableCell(withIdentifier: OrderConstant.VOrderTableViewCell, for: indexPath) as! OrderTableViewCell
        let dict = historyData[indexPath.row]
        cell.setHistoryData(dict: dict)
        
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension OrdersController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetailController = self.storyboard?.instantiateViewController(withIdentifier: OrderConstant.VOrderDetailController) as! OrderDetailController
        orderDetailController.orderId = historyData[indexPath.row].id ?? 0
        orderDetailController.historyType = historyType
        self.navigationController?.pushViewController(orderDetailController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
        
        let lastCell = (self.historyData.count) - 2
        if self.historyData.count >= 10 {
            if indexPath.row == lastCell {
                if nextpageurl != "" {
                    self.isUpdate = true
                    self.currentPage = currentPage + 1
                    getOrderHistory(isloader: false)
                }
            }
        }
    }
}


extension OrdersController:  OrderPresenterToOrderViewProtocol {
    func getHistory(historyEntity: HistoryEntity) {
        self.nextpageurl = historyEntity.historyResponseData?.next_page_url ?? ""


        

        if self.isUpdate  {
            if (historyEntity.historyResponseData?.data?.count ?? 0) > 0
            {
                for i in 0..<(historyEntity.historyResponseData?.data?.count ?? 0)
                {
                    if let dict = historyEntity.historyResponseData?.data?[i] {
                        self.historyData.append(dict)
                    }
                }
            }
        }else{
            historyData.removeAll()
            historyData = historyEntity.historyResponseData?.data ?? []
        }
        if historyData.count == 0 {
            if historyType == .ongoing {
                self.ordersTableView.setBackgroundImageAndTitle(imageName: OrderConstant.ic_no_history, title: OrderConstant.noOngoingOrder,tintColor: .blackColor)
            }else if historyType == .cancelled {
                self.ordersTableView.setBackgroundImageAndTitle(imageName: OrderConstant.ic_no_history, title: OrderConstant.noCancelledOrder,tintColor: .blackColor)
                
            }else if historyType == .past {
                self.ordersTableView.setBackgroundImageAndTitle(imageName: OrderConstant.ic_no_history, title: OrderConstant.noPastOrder,tintColor: .blackColor)
            }
        }else{
            self.ordersTableView.backgroundView = nil
        }
        ordersTableView.reloadData()
    }
    
    
}
