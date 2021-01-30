//
//  OrderStatusCell.swift
//  GoJekShop
//
//  Created by Sudar on 26/12/19.
//  Copyright © 2019 appoets. All rights reserved.
//

import UIKit

class OrderStatusCell: UITableViewCell {
        
    @IBOutlet weak var orderImageView: UIImageView!
    @IBOutlet weak var orderNameLabel: UILabel!
    @IBOutlet weak var orderNameInfoLabel: UILabel!
    @IBOutlet weak var orderdateLabel: UILabel!

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initalLoads()
    }
    
    private func initalLoads(){
      orderNameLabel.font = .setCustomFont(name: .medium, size: .x14)
        orderNameInfoLabel.font = .setCustomFont(name: .medium, size: .x14)
        orderdateLabel.font = .setCustomFont(name: .medium, size: .x14)
        orderImageView.imageTintColor(color1: .blackColor)
    }
    
}
