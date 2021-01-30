//
//  HomeController.swift
//  GoJekShop
//
//  Created by Sudar on 14/12/19.
//  Copyright © 2019 appoets. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

var requestCount = 0
class HomeController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var upcomingLabel: UILabel!
    
    var upcomingRequestArr = [UpcomingRequestData](){
        didSet{
            if(upcomingRequestArr.count > requestCount){
                AudioManager.share.startPlay()
                requestCount = upcomingRequestArr.count
            }
            else{
                AudioManager.share.stopSound()
                requestCount = upcomingRequestArr.count
            }
        }
    }
    var orderType:OrderType = .ordered
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initailLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orderType = .ordered
         self.socketAndBgTaskSetUp()
        self.showTabBar()

    }
    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
          BackGroundRequestManager.share.stopBackGroundRequest()
      }
}

extension HomeController {
    
    private func initailLoads() {
        setNavigationTitle()
        NotificationCenter.default.addObserver(self, selector: #selector(reconnectSocket), name: UIApplication.willEnterForegroundNotification, object: nil)
            self.homeTableView.setBackgroundImageAndTitle(imageName: HomeConstant.hourglass, title: HomeConstant.waitingOrder,tintColor: .blackColor)
        self.homeTableView.register(nibName: HomeConstant.TUpcomingRequestTableViewCell)
        self.title = APPConstant.appName
        self.tabBarItem.title = HomeConstant.THome
        self.homeTableView.backgroundColor = .backgroundColor
        self.view.backgroundColor = .backgroundColor
        upcomingLabel.font = .setCustomFont(name: .medium, size: .x18)
        upcomingLabel.text = HomeConstant.upcomingRequest
    }
    func socketAndBgTaskSetUp() {
        let saltKey = APPConstant.salt_key.fromBase64()
        if let shopId = AppManager.shared.storeId {
            BackGroundRequestManager.share.startBackGroundRequest(roomId: "room_\(saltKey ?? String.empty)_shop_\(shopId)", listener: .NewRequest)
            BackGroundRequestManager.share.requestCallback = { [weak self] in
                guard let self = self else {
                    return
                }
                self.orderType = .ordered
                self.callHomeApi()
            }
        }else{
            callHomeApi()
        }
    }
    
    func callHomeApi(){
        let param: Parameters = [HomeConstant.type:orderType.currentType]
         self.homePresenter?.upcomingRequest(param: param)
    }
    @objc private func reconnectSocket() {
          BackGroundRequestManager.share.resetBackGroudTask()
          self.callHomeApi()
          socketAndBgTaskSetUp()
      }
}

//MARK:- UITableViewDataSource

extension HomeController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingRequestArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeConstant.TUpcomingRequestTableViewCell, for: indexPath) as! UpcomingRequestTableViewCell
        let dict = self.upcomingRequestArr[indexPath.row]
        cell.paymentLabel.text = dict.invoice?.payment_mode
        cell.orderTimeValueLabel.text = dateToString(dateStr: dict.created_time ?? "")
        if let addr = dict.delivery?.map_address {
            cell.addrView.isHidden = false
            cell.locationLabel.text = addr

        }else{
            cell.addrView.isHidden = true

        }
        let name = (dict.user?.first_name ?? "") + (dict.user?.last_name ?? "")
        cell.userNameLabel.text = name
        cell.orderTimeLabel.text = HomeConstant.orderTime
        // cell.statusLabel.text = dict.status
        
        if dict.order_type == "TAKEAWAY" {
           // cell.locationImageView.isHidden = true
            cell.locationImageView.image = UIImage.init(named: HomeConstant.takeaway)
            cell.locationLabel.text = "TakeAway"
        }
        cell.statusLabel.text = " " + (dict.status ?? "") + "  "

        if dict.status == "SEARCHING" && dict.status == "ORDERED" {
            cell.statusLabel.backgroundColor = .green
        }else {
            cell.statusLabel.backgroundColor = .red

        }
        
        if let imageUrl = URL(string: dict.user?.picture ?? ""){
            cell.userImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: AccountConstant.icprofile))
            
        }else {
            cell.userImageView.image = UIImage(named: AccountConstant.icprofile)
        }
        return cell
    }
}

//MARK:- UITableViewDelegate

extension HomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.upcomingRequestArr.count > 0) {
            let homeDetailController = self.storyboard?.instantiateViewController(withIdentifier: HomeConstant.VHomeDetailController) as! HomeDetailController
            homeDetailController.upcomingRequestData = self.upcomingRequestArr[indexPath.row]
            homeDetailController.delegate = self
            homeDetailController.orderType = orderType
            self.navigationController?.pushViewController(homeDetailController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



//MARK:- HomePresenterToHomeViewProtocol

extension HomeController: HomePresenterToHomeViewProtocol {
    
    func upcomingRequestSuccess(upcomingRequestEntity: UpcomingRequestEntity) {
    //    LoadingIndicator.hide()
        upcomingRequestArr = upcomingRequestEntity.responseData ?? []
        if upcomingRequestArr.count == 0 {
            self.homeTableView.setBackgroundImageAndTitle(imageName: HomeConstant.hourglass, title: HomeConstant.waitingOrder,tintColor: .blackColor)
        }else {
            self.homeTableView.backgroundView = nil
        }
        homeTableView.reloadData()
    }
}

func dateToString(dateStr: String) -> String {
    let baseConfig = AppConfigurationManager.shared.baseConfigModel

    let dateFormatter = DateFormatter()
    if baseConfig?.responseData?.appsetting?.date_format == "1" {
        dateFormatter.dateFormat = DateFormat.yyyy_mm_dd_hh_mm_ss

    }else{
        dateFormatter.dateFormat = DateFormat.dd_mm_yyyy_hh_mm_ss_a

    }

    let dateFromString = dateFormatter.date(from: dateStr)
    guard let currentDate = dateFromString else {
        return ""
    }
    let dateFormatter2 = DateFormatter()
    dateFormatter2.dateFormat = "h:mm a"
    let stringFromDate = dateFormatter2.string(from: currentDate)
    return stringFromDate
}

extension HomeController : updatesocketDelegate {
    func updateSocket() {
        callHomeApi()
    }
}
