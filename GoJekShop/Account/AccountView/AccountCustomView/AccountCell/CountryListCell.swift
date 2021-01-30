//
//  CountryListCell.swift
//  GoJekProvider
//
//  Created by apple on 19/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class CountryListCell: UITableViewCell {
    
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //        countryNameLabel.textAlignment = .left
        countryCodeLabel.textAlignment = .right
        countryNameLabel.font = .setCustomFont(name: .light, size: .x18)
        countryCodeLabel.font = .setCustomFont(name: .light, size: .x18)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //Set cell value
    func set(values: Country){
        
        countryImageView.image = UIImage(named: "CountryPicker.bundle/"+values.code)
        countryCodeLabel.text = values.dial_code
        countryNameLabel.text = values.name
    }
    
}
