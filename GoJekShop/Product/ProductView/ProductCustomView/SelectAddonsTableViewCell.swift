//
//  SelectAddonsTableViewCell.swift
//  GoJekShop
//
//  Created by Sudar on 11/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit

class SelectAddonsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addonsNameLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var priceTextField: CustomTextField!
    
    weak var delegate: SelectAddonsCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupData()
    }
    
    private func setupData(){
        addonsNameLabel.font = .setCustomFont(name: .medium, size: .x14)
        checkImageView.image = UIImage(named: Constant.circleImage)
        priceTextField.placeholder = ProductConstant.price
        priceTextField.keyboardType = .numberPad
        priceTextField.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

//MARK:- UITextFieldDelegate

extension SelectAddonsTableViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.tag)
        delegate?.didSelectTextField(index: textField.tag,textFieldStr: priceTextField.text ?? String.empty)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentView.endEditing(true)
        return true
    }
}

//MARK:- SelectAddonsCellDelegate

protocol SelectAddonsCellDelegate: class {
    
    func didSelectTextField(index: Int,textFieldStr: String)
}
