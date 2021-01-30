//
//  UpcomingRequestTableViewCell.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 27/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class UpcomingRequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var orderTimeValueLabel: UILabel!
    @IBOutlet weak var orderTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var addrView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initalLoad()
    }
    
    private func initalLoad(){
        userImageView.image = UIImage(named: AccountConstant.icprofile)
        
        setFont()
        contentView.backgroundColor = .backgroundColor
        overView.backgroundColor = .boxColor
        overView.setCornerRadiuswithValue(value: 8)
        locationImageView.image = UIImage(named: HomeConstant.location)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.userImageView.setRoundCorner()
            self.statusLabel.setCornerRadiuswithValue(value: 8)
        }
    }
    
    private func setFont(){
        paymentLabel.font = .setCustomFont(name: .medium, size: .x14)
        orderTimeLabel.font = .setCustomFont(name: .medium, size: .x14)
        orderTimeValueLabel.font = .setCustomFont(name: .medium, size: .x14)
        locationLabel.font = .setCustomFont(name: .medium, size: .x14)
        userNameLabel.font = .setCustomFont(name: .medium, size: .x14)
        statusLabel.font = .setCustomFont(name: .medium, size: .x14)
    }
}
