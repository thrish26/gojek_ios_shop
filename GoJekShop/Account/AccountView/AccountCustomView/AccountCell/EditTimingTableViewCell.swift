//
//  EditTimingTableViewCell.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 26/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class EditTimingTableViewCell: UITableViewCell {
    @IBOutlet weak var openOutterView: UIView!
    
    @IBOutlet weak var closeOutterView: UIView!
    @IBOutlet weak var radioImageView: UIImageView!
    @IBOutlet weak var closeTimeValueLabel: UILabel!
    @IBOutlet weak var openTimeValueLabel: UILabel!
    @IBOutlet weak var clockImageView1: UIImageView!
    @IBOutlet weak var closeTimeLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var clockImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var topTitleView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        changeTintColor()
        setTitle()
        setFont()
        self.contentView.backgroundColor = .backgroundColor
        self.openOutterView.backgroundColor = .boxColor
        self.closeOutterView.backgroundColor = .boxColor

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setTitle(){
        openTimeLabel.text = AccountConstant.openTime.localized
        closeTimeLabel.text = AccountConstant.closeTime.localized
    }
    
    private func setFont(){
        openTimeValueLabel.font = .setCustomFont(name: .medium, size: .x14)
        closeTimeValueLabel.font = .setCustomFont(name: .medium, size: .x14)
        closeTimeLabel.font = .setCustomFont(name: .medium, size: .x14)
        openTimeLabel.font = .setCustomFont(name: .medium, size: .x14)
        dayLabel.font = .setCustomFont(name: .medium, size: .x14)
        
    }
    
    private func changeTintColor(){
        clockImageView1.imageTintColor(color1: .gray)
        clockImageView.imageTintColor(color1: .gray)
        //  radioImageView.imageTintColor(color1: .gray)
        
    }
    
    
    
}
