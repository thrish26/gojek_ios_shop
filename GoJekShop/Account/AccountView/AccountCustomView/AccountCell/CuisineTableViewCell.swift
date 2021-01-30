//
//  CustomTableViewCell.swift
//  GoJekShop
//
//  Created by Sudar on 04/03/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit

class CuisineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var checkImageView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setFont()
    }
    
    private func setFont(){
        titleLabel.font = .setCustomFont(name: .medium, size: .x14)
    }
    
    
}
