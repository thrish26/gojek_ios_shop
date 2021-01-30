//
//  AddOnsListTableViewCell.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 06/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class AddOnsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var addOnsNameLabel: UILabel!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate : AddOnsListTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initalLoads()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        overView.setCornerRadiuswithValue(value: 5)
    }
    
    private func initalLoads(){
        setFont()
        self.contentView.backgroundColor = .backgroundColor
        overView.backgroundColor = .boxColor
    }
    
    private func setFont(){
        addOnsNameLabel.font = .setCustomFont(name: .medium, size: .x14)
        removeButton.titleLabel?.font = .setCustomFont(name: .medium, size: .x14)
    }
    
    func setAddonsData(addonsDict: AddonsData,tagIndex: Int){
        addOnsNameLabel.text = addonsDict.addon_name
        deleteButton.addTarget(self, action: #selector(TapOnDeleteAddonAction(_:)), for: .touchUpInside)
        
        deleteButton.tag = tagIndex
    }
    
    @objc func TapOnDeleteAddonAction(_ sender: UIButton){
        
        delegate?.deleteAddons(tagIndex: sender.tag)
    }
}

// MARK:- AddOnsListTableViewCellDelegate

protocol AddOnsListTableViewCellDelegate: class {
    func deleteAddons(tagIndex: Int)
}
