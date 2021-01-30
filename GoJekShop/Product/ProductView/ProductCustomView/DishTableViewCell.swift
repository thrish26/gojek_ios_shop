//
//  DishTableViewCell.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit

class DishTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.font = .setCustomFont(name: .bold, size: .x16)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        overView.setCornerRadiuswithValue(value: 5)
        overView.backgroundColor = .boxColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
