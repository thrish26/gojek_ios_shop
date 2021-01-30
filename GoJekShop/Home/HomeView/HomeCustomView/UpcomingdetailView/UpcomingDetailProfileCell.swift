//
//  UpcomingDetailProfileCell.swift
//  GoJekShop
//
//  Created by Sudar on 16/12/19.
//  Copyright © 2019 appoets. All rights reserved.
//

import UIKit

class UpcomingDetailProfileCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var orderListLabel: UILabel!
    @IBOutlet weak var orderListImageView: UIImageView!
    @IBOutlet weak var overView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initalLoad()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.profileImageView.setRoundCorner()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func initalLoad(){
        setColor()
        setFont()
        setTitle()
        setImage()
    }
    
    private func setTitle(){
        orderListLabel.text = HomeConstant.orderList
    }
    
    private func setImage(){
        profileImageView.image = UIImage(named: AccountConstant.icprofile)
        orderListImageView.image = UIImage(named: HomeConstant.orderList)
        orderListImageView.imageTintColor(color1: .blackColor)
        callButton.setImage(UIImage(named: HomeConstant.ic_phone), for: .normal)
    }
    
    private func setColor(){
        contentView.backgroundColor = .backgroundColor
        overView.backgroundColor = .backgroundColor
        addressLabel.textColor = .lightGray
    }
    
    private func setFont(){
        orderListLabel.font = .setCustomFont(name: .medium, size: .x14)
        nameLabel.font = .setCustomFont(name: .bold, size: .x14)
        paymentLabel.font = .setCustomFont(name: .medium, size: .x14)
        addressLabel.font = .setCustomFont(name: .medium, size: .x14)
    }
}
