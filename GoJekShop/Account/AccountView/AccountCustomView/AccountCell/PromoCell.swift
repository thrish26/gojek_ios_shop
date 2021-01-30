//
//  PromoCell.swift
//  GoJekShop
//
//  Created by JeyaPrakash on 07/11/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit

class PromoCell: UITableViewCell {

      
        @IBOutlet weak var overView: UIView!
        @IBOutlet weak var categoryImageView: UIImageView!
        @IBOutlet weak var categoryNameLabel: UILabel!
        @IBOutlet weak var categoryDesLabel: UILabel!
        @IBOutlet weak var deleteButton: UIButton!
        
        open weak var categoryDelegate : AddCategoryTableViewCellDelegate?
        open weak var productDelegate : AddProductTableViewCellDelegate?
        var isProduct = false
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            setFont()
            overView.backgroundColor = .boxColor
            contentView.backgroundColor = .backgroundColor
            deleteButton.setImage(UIImage(named: Constant.ic_error), for: .normal)
        }
        
        
        override func layoutSubviews() {
            overView.addShadow(radius: 0.5, color: .lightGray)
            categoryImageView.setCornerRadiuswithValue(value: 0.8)
        }
        
        private func setFont(){
            categoryNameLabel.font = .setCustomFont(name: .bold, size: .x16)
            categoryDesLabel.font = .setCustomFont(name: .medium, size: .x14)
        }
        
        func setCategoryData(categoryData: CategoryData,tagIndex: Int){
            categoryDesLabel.text = categoryData.store_category_description
            categoryNameLabel.text = categoryData.store_category_name
            deleteButton.addTarget(self, action: #selector(TapOnDeleteCategoryAction(_:)), for: .touchUpInside)
            deleteButton.tag = tagIndex
            isProduct = false

            if let categoryImageUrl = URL(string: categoryData.picture ?? ""){
                categoryImageView.sd_setImage(with: categoryImageUrl, placeholderImage: UIImage(named: ProductConstant.dummy))
                
            }else{
                categoryImageView.image = UIImage(named: ProductConstant.dummy)
            }
        }
        
        func setPromoData(promoData: PromoCodeData,tagIndex: Int){
             categoryDesLabel.text = promoData.promo_description
             categoryNameLabel.text = promoData.promo_code
             deleteButton.addTarget(self, action: #selector(TapOnDeleteCategoryAction(_:)), for: .touchUpInside)
             deleteButton.tag = tagIndex
             isProduct = true
             if let productImageUrl = URL(string: promoData.picture ?? ""){
                 categoryImageView.sd_setImage(with: productImageUrl, placeholderImage: UIImage(named: ProductConstant.dummy))
                 
             }else{
                 categoryImageView.image = UIImage(named: ProductConstant.dummy)
             }
         }
        
        
        @objc func TapOnDeleteCategoryAction(_ sender: UIButton){
            
            if isProduct {
                productDelegate?.deleteProduct(tagIndex: sender.tag)
            }else{
            categoryDelegate?.deleteCategory(tagIndex: sender.tag)
            }
            
        }
    }



