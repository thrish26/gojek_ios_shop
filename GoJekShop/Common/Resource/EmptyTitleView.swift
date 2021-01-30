//
//  EmptyTitleView.swift
//  GoJekUser
//
//  Created by CSS on 06/06/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class EmptyTitleView: UIView {
    
    lazy var labelTitle:UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.font = UIFont.setCustomFont(name: .bold, size: .x16)
        return title
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(labelTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    func setConstraints() {
        
        
        //labelTitle
        labelTitle.centerYAnchor.constraint(equalTo: (labelTitle.superview!.centerYAnchor)).isActive = true
        labelTitle.centerXAnchor.constraint(equalTo: (labelTitle.superview!.centerXAnchor)).isActive = true
        labelTitle.leftAnchor.constraint(equalTo: (labelTitle.superview!.leftAnchor),constant:20).isActive = true
        labelTitle.rightAnchor.constraint(equalTo: (labelTitle.superview!.rightAnchor),constant:-20).isActive = true
        
    }
    
}
