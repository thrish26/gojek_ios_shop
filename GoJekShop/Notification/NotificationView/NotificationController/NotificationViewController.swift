//
//  NotificationViewController.swift
//  GoJekShop
//
//  Created by Anusuya on 18/09/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var notificationTbleView: UITableView!
    
    var cellHeights: [IndexPath : CGFloat] = [:]
    var notificationData:[NotificationData] = []
    var isUpdate:Bool = false
    var nextpageurl = ""
    var currentPage = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialLoads()
    }
    
    func intialLoads(){
        
        self.setNavigationBar()
        self.notificationTbleView.register(UINib(nibName: NotificationConstant.NotificationTableViewCell, bundle: nil), forCellReuseIdentifier: NotificationConstant.NotificationTableViewCell)
        notificationTbleView.dataSource = self
        notificationTbleView.delegate = self
        self.notificationTbleView.separatorColor = UIColor.clear
    }
    
    private func setNavigationBar() {
        setNavigationTitle()
        self.title = NotificationConstant.TNotification.localized
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        showTabBar()
        getNotification()
    }
    private func getNotification() {
        
        self.notificationPresenter?.getNotification(param: [NotificationConstant.page:currentPage], isHideIndicator: isUpdate)
    }
}
extension NotificationViewController: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationData.count
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
          guard let height = cellHeights[indexPath] else { return 170.0 }
          return height
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationTbleView.dequeueReusableCell(withIdentifier: NotificationConstant.NotificationTableViewCell) as! NotificationTableViewCell
        cell.setValues(values: self.notificationData[indexPath.row])
        cell.layoutSubviews()
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
        let lastCell = (self.notificationData.count) - 2
        if self.notificationData.count >= 10 {
            if indexPath.row == lastCell {
                if nextpageurl != "" {
                    self.isUpdate = true
                    currentPage = currentPage + (self.notificationData.count)
                    getNotification()
                }
            }
        }
    }
}
extension NotificationViewController:  NotificationPresenterToNotificationViewProtocol {
    func getNotification(notificationEntity: NotificationEntity) {
        self.nextpageurl = notificationEntity.responseData?.notification?.next_page_url ?? ""
        if self.isUpdate {
            for i in 0..<(notificationEntity.responseData?.notification?.data?.count ?? 0)
            {
                if let dict = notificationEntity.responseData?.notification?.data?[i] {
                    print(dict)
                    notificationData.append(dict)
                }
            }
        }else {
            notificationData.removeAll()
            self.notificationData = notificationEntity.responseData?.notification?.data ?? []
            
        }
        if self.notificationData.count == 0 {
            self.notificationTbleView.setBackgroundImageAndTitle(imageName: NotificationConstant.noNotification, title: NotificationConstant.notificationEmpty.localized,tintColor: .black)
        }else
        {
            self.notificationTbleView.backgroundView = nil
        }
        
        self.notificationTbleView.reloadData()
        
        
    }
}
