//
//  DeliveryChargeCell.swift
//  GoJekShop
//
//  Created by Sudar on 16/12/19.
//  Copyright © 2019 appoets. All rights reserved.
//

import UIKit

class DeliveryChargeCell: UITableViewCell {
    
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var taxView: UIView!
    @IBOutlet weak var storePackageView: UIView!
    @IBOutlet weak var deliveryView: UIView!
    @IBOutlet weak var itemTotalView: UIView!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var discountValueLabel: UILabel!
    @IBOutlet weak var deliverychargeLabel: UILabel!
    @IBOutlet weak var deliverychargeValueLabel: UILabel!
    @IBOutlet weak var storePackageLabel: UILabel!
    @IBOutlet weak var storePackageValueLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var taxValueLabel: UILabel!
    @IBOutlet weak var couponLabel: UILabel!
    @IBOutlet weak var couponValueLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemPriceValueLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var couponView: UIView!
    @IBOutlet weak var overView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initalLoads()
    }
    
    private func initalLoads(){
        setFont()
        setValues()
        contentView.backgroundColor = .backgroundColor
        itemTotalView.backgroundColor = .backgroundColor
        deliveryView.backgroundColor = .backgroundColor
        storePackageView.backgroundColor = .backgroundColor
        taxView.backgroundColor = .backgroundColor
        couponView.backgroundColor = .backgroundColor
        discountView.backgroundColor = .backgroundColor
        totalView.backgroundColor = .backgroundColor

    }
    
    private func setFont(){
        discountLabel.font = .setCustomFont(name: .medium, size: .x14)
        discountValueLabel.font = .setCustomFont(name: .medium, size: .x14)
        deliverychargeLabel.font = .setCustomFont(name: .medium, size: .x14)
        deliverychargeValueLabel.font = .setCustomFont(name: .medium, size: .x14)
        storePackageLabel.font = .setCustomFont(name: .medium, size: .x14)
        storePackageValueLabel.font = .setCustomFont(name: .medium, size: .x14)
        taxLabel.font = .setCustomFont(name: .medium, size: .x14)
        taxValueLabel.font = .setCustomFont(name: .medium, size: .x14)
        
        couponLabel.font = .setCustomFont(name: .medium, size: .x14)
        couponValueLabel.font = .setCustomFont(name: .medium, size: .x14)
        totalLabel.font = .setCustomFont(name: .medium, size: .x14)
        totalValueLabel.font = .setCustomFont(name: .medium, size: .x14)
        itemPriceLabel.font = .setCustomFont(name: .medium, size: .x14)
        itemPriceValueLabel.font = .setCustomFont(name: .medium, size: .x14)
    }
    
    private func setValues(){
        deliverychargeLabel.text = HomeConstant.deliveryCharge.localized
        discountLabel.text =  HomeConstant.discount.localized
        storePackageLabel.text = HomeConstant.storePackage.localized
        taxLabel.text = HomeConstant.taxAmount.localized
        totalLabel.text = HomeConstant.total.localized
        couponLabel.text = HomeConstant.coupon.localized
        itemPriceLabel.text = HomeConstant.TItemPrice.localized
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
