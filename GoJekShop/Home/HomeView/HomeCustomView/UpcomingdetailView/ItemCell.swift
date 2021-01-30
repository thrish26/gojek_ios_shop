//
//  ItemCell.swift
//  GoJekShop
//
//  Created by Sudar on 16/12/19.
//  Copyright © 2019 appoets. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var outterView: UIView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addonsNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .boxColor
        outterView.backgroundColor = .boxColor
        overView.backgroundColor = .appPrimaryColor
        setFont()
        overView.setCornerRadiuswithValue(value: 2)
        addonsNameLabel.textColor = .lightGray
    }
    
    private func setFont(){
        itemNameLabel.textColor = .lightGray
        quantityLabel.textColor = .lightGray
        priceLabel.textColor = .lightGray
        addonsNameLabel.textColor = .lightGray
        itemNameLabel.font = .setCustomFont(name: .medium, size: .x12)
        quantityLabel.font = .setCustomFont(name: .medium, size: .x12)
        priceLabel.font = .setCustomFont(name: .medium, size: .x12)
        addonsNameLabel.font = .setCustomFont(name: .medium, size: .x12)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
