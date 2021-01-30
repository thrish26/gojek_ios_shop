//
//  OrderListCell.swift
//  GoJekShop
//
//  Created by Sudar on 02/01/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit

class OrderListCell: UITableViewCell {
    
    @IBOutlet weak var orderListLabel: UILabel!
       @IBOutlet weak var orderListImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initlLoads()
    }
    
    private func initlLoads(){
        orderListImageView.image = UIImage(named: HomeConstant.orderList)
        orderListImageView.imageTintColor(color1: .blackColor)
        orderListLabel.text = HomeConstant.TorderList
        orderListLabel.font = .setCustomFont(name: .medium, size: .x16)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
