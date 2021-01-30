//
//  CustomTableCell.swift
//  GoJekUser
//
//  Created by Ansar on 22/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class CustomTableCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.font = UIFont.setCustomFont(name: .medium, size: .x16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
