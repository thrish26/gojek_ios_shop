//
//  OrderTableViewCell.swift
//  MySample
//
//  Created by CSS01 on 20/02/19.
//  Copyright © 2019 CSS01. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    
    // Outlets
    @IBOutlet weak var orderIDLbl: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceValueLabel: UILabel!
    @IBOutlet weak var paymentTypeLabel: UILabel!
    @IBOutlet weak var dateBackgroundView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var locationImgVw: UIImageView!
    var historyType:historyType = .past
    // LifeCycles
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialLoads()
      
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
}

//MARK: Methods

extension OrderTableViewCell {
    private func initialLoads() {
        self.dateBackgroundView.backgroundColor = .appPrimaryColor
        self.backGroundView.setCornerRadiuswithValue(value: 5)
        self.backGroundView.backgroundColor = .boxColor
        setFont()
        priceValueLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setHistoryData(dict: Historydata){
        
        if dict.order_type == "TAKEAWAY" {
            addressLabel.text = "TakeAway"
            locationImgVw.image = UIImage.init(named: HomeConstant.takeaway)
        }else{
            addressLabel.text = dict.delivery?.street
        }
        orderIDLbl.text = dict.store_order_invoice_id
        nameLabel.text = ((dict.user?.first_name ?? "") +  (dict.user?.last_name ?? ""))
      
        if let dateStr = dict.created_time {
            let assignedAt = AppUtils.shared.dateToStringAm(dateStr: dateStr)
            setDateAndTime(dateString: assignedAt)
        }
        paymentTypeLabel.text = dict.payment_mode
        let price = ((dict.currency ?? "") + (dict.total_amount ?? ""))
        priceValueLabel.text = price
        priceLabel.text = "Price"
        paymentLabel.text = "Payment via"
        
    }
    
    func setDateAndTime(dateString:String) {
        print("dateString---->",dateString)
        let seperatedStrArr = dateString.components(separatedBy: ",")
        if seperatedStrArr.count > 1 {
            self.timeLabel.text = String.removeNil(seperatedStrArr[1])
            self.dateLabel.text =  String.removeNil(seperatedStrArr[0])
        } else  {
            self.timeLabel.text = ""
            self.dateLabel.text =  String.removeNil(seperatedStrArr[0])
        }
    }
    
    
    
    private func setFont() {
        
        paymentLabel.font = UIFont.setCustomFont(name: .bold, size: .x14)
        nameLabel.font = UIFont.setCustomFont(name: .medium, size: .x14)
        dateLabel.font = UIFont.setCustomFont(name: .medium, size: .x14)
        timeLabel.font = UIFont.setCustomFont(name: .medium, size: .x14)
      paymentLabel.font = UIFont.setCustomFont(name: .medium, size: .x14)
       priceLabel.font = UIFont.setCustomFont(name: .medium, size: .x14)
         priceValueLabel.font = UIFont.setCustomFont(name: .medium, size: .x14)
         paymentTypeLabel.font = UIFont.setCustomFont(name: .medium, size: .x14)
          addressLabel.font = UIFont.setCustomFont(name: .medium, size: .x14)
        orderIDLbl.font = UIFont.setCustomFont(name: .bold, size: .x16)
        orderIDLbl.textColor = .appPrimaryColor
    }
    
 
    
}
