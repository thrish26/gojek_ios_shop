//
//  TableViewExtension.swift
//  GoJekUser
//
//  Created by apple on 27/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(nibName: String) {
        let Nib = UINib(nibName: nibName, bundle: nil)
        register(Nib, forCellReuseIdentifier: nibName)
    }
    
    func reloadInMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func setBackgroundTitle(title:String) {
        let emptyDataView = EmptyTitleView(frame: self.bounds)
        emptyDataView.labelTitle.text = title
        self.backgroundView = emptyDataView
        
    }
    
    func setBackgroundImageTitle(imageName:String?,title:String) {
        let emptyDataView = EmptyView(frame: self.bounds)
        if let image  = imageName  {
            emptyDataView.imageView.image = UIImage(named: image)
        }
        emptyDataView.labelTitle.text = title
        self.backgroundView = emptyDataView
        
    }
    
    func setBackgroundImageAndTitle(imageName:String?,title:String,tintColor: UIColor) {
        let emptyDataView = EmptyView(frame: self.bounds)
        if let image  = imageName  {
            emptyDataView.imageView.image = UIImage(named: image)?.imageTintColor(color1: tintColor)
        }
        emptyDataView.labelTitle.text = title
        self.backgroundView = emptyDataView
        
    }
}
