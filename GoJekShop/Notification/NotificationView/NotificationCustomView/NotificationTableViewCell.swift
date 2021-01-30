//
//  NotificationTableViewCell.swift
//  MySample
//
//  Created by CSS01 on 20/02/19.
//  Copyright © 2019 CSS01. All rights reserved.
//

import UIKit
import SDWebImage
class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var notificationTitleLabel: UILabel!
    @IBOutlet weak var notificationDetailLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var notificationImage: UIImageView!
    
    @IBOutlet weak var showButton: UIButton!
    
    var isShowMoreLess = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialLoads()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.notificationImage.setCornerRadiuswithValue(value: 5)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setValues(values: NotificationData) {
        let placeHolderImage = UIImage(named: Constant.imagePlaceHolder)?.imageTintColor(color1: UIColor.veryLightGray.withAlphaComponent(0.5))
        
        self.notificationImage.sd_setImage(with: URL(string: values.image ?? "")  , placeholderImage: placeHolderImage,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            // Perform operation.
            if (error != nil) {
                // Failed to load image
                self.notificationImage.image = placeHolderImage
            } else {
                // Successful in loading image
                self.notificationImage.image = image
            }
        })
        self.notificationTitleLabel.text = values.title
        self.notificationDetailLabel.text = values.descriptions
        let date = values.created_at?.dateDiff()
        self.timeLeftLabel.text = date ?? ""
        
        let lblLineCount = countLabelLines(label: notificationDetailLabel)
        
        if lblLineCount >= 3 {
            showButton.isHidden = false
        }else{
            showButton.isHidden = true
        }
    }
    
    private func countLabelLines(label: UILabel) -> Int {
        // Call self.layoutIfNeeded() if your view uses auto layout
        let myText = label.text! as NSString
        
        let rect = CGSize(width: label.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label.font ?? 12], context: nil)
        
        return Int(ceil(CGFloat(labelSize.height) / label.font.lineHeight))
    }
}

extension NotificationTableViewCell {
    
    private func initialLoads() {
        
        notificationTitleLabel.font  = UIFont.setCustomFont(name: .medium, size: .x18)
        timeLeftLabel.font  = UIFont.setCustomFont(name: .medium, size: .x12)
        notificationDetailLabel.font  = UIFont.setCustomFont(name: .medium, size: .x14)
        backGroundView.addShadow(radius: 5.0, color: UIColor.lightGray)
        backGroundView.backgroundColor = .boxColor
        notificationDetailLabel.numberOfLines = 3
        showButton.titleLabel?.font = UIFont.setCustomFont(name: .medium, size: .x14)
        showButton.setTitleColor(.red, for: .normal)
        showButton.setTitle(HomeConstant.showMore.localize(), for: .normal)
    }
}
