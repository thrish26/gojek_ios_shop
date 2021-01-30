//
//  CollectionViewExtension.swift
//  GoJekUser
//
//  Created by apple on 27/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register(nibName: String) {
        let Nib = UINib(nibName: nibName, bundle: nil)
        register(Nib, forCellWithReuseIdentifier: nibName)
    }
    
    func reloadInMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func setBackView(imageName:String,message:String)  {
        let imageView: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: imageName)
            image.contentMode = .scaleAspectFit
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        
        let _: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.backgroundColor = .lightGray
            label.text = message
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        self.backgroundView = imageView
        
        imageView.centerXAnchor.constraint(equalToSystemSpacingAfter: self.centerXAnchor, multiplier: 1.0).isActive = true
        imageView.centerYAnchor.constraint(equalToSystemSpacingBelow: self.centerYAnchor, multiplier: 1.0).isActive = true
        DispatchQueue.main.async {
            imageView.setCornerRadius()
        }
    }
    
    func setBackgroundTitle(title:String) {
        let emptyDataView = EmptyTitleView(frame: self.bounds)
        emptyDataView.labelTitle.text = title
        self.backgroundView = emptyDataView
        
    }
    
    func setBackgroundImageAndTitle(imageName:String?,title:String) {
        let emptyDataView = EmptyView(frame: self.bounds)
        if let image  = imageName  {
            emptyDataView.imageView.image = UIImage(named: image)
        }
        
        emptyDataView.labelTitle.text = title
        self.backgroundView = emptyDataView
    }
}

extension UICollectionViewCell {
    
    static var reuseIdentifier: String! {
        
        let className = String(describing: self)
        return className
    }
}
