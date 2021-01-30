//
//  EmptyView.swift
//  orderAround
//
//  Created by Ansar on 01/02/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    var imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints =  false
        imgView.contentMode = UIView.ContentMode.scaleAspectFit
        return imgView
    }()
    
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
        self.addSubview(imageView)
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
        //imageView
        imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive  =  true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive =  true
        imageView.centerXAnchor.constraint(equalTo: (imageView.superview!.centerXAnchor)).isActive = true
        imageView.centerYAnchor.constraint(equalTo: (imageView.superview!.centerYAnchor),constant:-20).isActive = true
        
        //labelTitle
        labelTitle.topAnchor.constraint(equalTo: (imageView.bottomAnchor),constant:20).isActive = true
        labelTitle.centerXAnchor.constraint(equalTo: (labelTitle.superview!.centerXAnchor)).isActive = true
        labelTitle.leftAnchor.constraint(equalTo: (labelTitle.superview!.leftAnchor),constant:20).isActive = true
        labelTitle.rightAnchor.constraint(equalTo: (labelTitle.superview!.rightAnchor),constant:-20).isActive = true
        
    }
    
}


