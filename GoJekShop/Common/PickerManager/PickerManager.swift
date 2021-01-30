//
//  PickerManager.swift
//  GoJekUser
//
//  Created by Rajes on 03/04/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

public typealias PickerCompletion = (String)

enum CustomPickerType {
    
    case DOB
    case Other
}


class PickerManager {
    
    static let shared = PickerManager()
    
    func showDatePicker(selectedDate: String?,minDate:Date? = nil ,completionHandler : @escaping (PickerCompletion) -> Void) {
        
        CustomPicker.showDatePicker(type: .date, sourceVC: UIApplication.topViewController()!, minDate: minDate, maxDate: nil, selectedDate: selectedDate) { (selectdValue) in
            completionHandler(selectdValue)
        }
    }
    
    func showTimePicker(selectedDate: String?,minDate:Date? = nil, completionHandler : @escaping (PickerCompletion) -> Void) {
        
        CustomPicker.showDatePicker(type: .time, sourceVC: UIApplication.topViewController()!, minDate: minDate, maxDate: nil, selectedDate: selectedDate) { (selectdValue) in
            completionHandler(selectdValue)
        }
    }
    
    func showDateAndTimePicker(selectedDate: String?,minDate:Date? = nil, completionHandler : @escaping (PickerCompletion) -> Void) {
        
        CustomPicker.showDatePicker(type: .dateAndTime, sourceVC: UIApplication.topViewController()!, minDate: minDate, maxDate: nil, selectedDate: selectedDate) { (selectdValue) in
            completionHandler(selectdValue)
        }
    }
    
    func showPicker(pickerData:[String],selectedData: String?, completionHandler : @escaping (PickerCompletion) -> Void) {
        CustomPicker.showPicker(sourceVC: UIApplication.topViewController()!, pickerDataSource: pickerData, selectedData: selectedData) { (selectdValue) in
            completionHandler(selectdValue)
        }
    }
    
}

fileprivate class CustomPicker: NSObject {
    
    static var delegate: CustomPickerDelegate = CustomPickerDelegate()
    
    static var completionHandler: ((String) -> Void)? = {_ in }
    
    static var pickerConstraints: NSLayoutConstraint!
    
    static var currentVC: UIViewController? = {
        let newvc = UIViewController()
        newvc.view.backgroundColor = UIColor.clear
        newvc.modalPresentationStyle = .overFullScreen
        newvc.modalTransitionStyle = .crossDissolve
        return newvc
    }()
    
    static var dummyBackgroundView: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.backgroundColor = UIColor.clear
        sView.alpha = 0.5
        return sView
    }()
    
    static var picker: UIPickerView = {
        let pic = UIPickerView()
        pic.tag = 100
        return pic
    }()
    
    
    
    static var selectedValue = ""
    
    static func showPicker(sourceVC: UIViewController, pickerDataSource: [String], selectedData: String?, closure:@escaping (PickerCompletion) -> Void) {
        
        currentVC?.view.addSubview(dummyBackgroundView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        currentVC?.view.addGestureRecognizer(tap)
        currentVC?.view.isUserInteractionEnabled = true
        if let sub = currentVC?.view.subviews {
            for sview in sub {
                if sview.tag != 100 {
                    picker.delegate = delegate
                    picker.dataSource = delegate
                    picker.backgroundColor = .whiteColor
                    currentVC?.view.addSubview(picker)
                }
            }
        }
        
        var selected = 0
        var selectRow = 0
        if let sData = selectedData {
            selected = pickerDataSource.firstIndex(of: sData) ?? 0
            let index = pickerDataSource.firstIndex(of: sData) ?? 0
            selectRow = index
            
        }
        
        delegate.initWithDataSource(dataSource: pickerDataSource, sIndex: selected)
        
        
        
        setPickerFrame(pickerView: picker, vc: currentVC!)
        sourceVC.present(currentVC!, animated: true, completion: nil)
        completionHandler = { value in
            closure((value))
        }
        
        openPickerView()
        
        if let _ = selectedData {
            DispatchQueue.main.async {
                picker.selectRow(selectRow, inComponent: 0, animated: true)
            }
            
        } else {
            DispatchQueue.main.async {
                picker.selectRow(0, inComponent: 0, animated: true)
            }
        }
        
        if let handler = CustomPicker.completionHandler {
            
            handler(pickerDataSource[selected])
        }
    }
    
    static func showDatePicker(type:UIDatePicker.Mode,sourceVC: UIViewController, minDate: Date?, maxDate: Date?, selectedDate: String?, closure:@escaping (PickerCompletion) -> Void) {
        
        currentVC?.view.addSubview(dummyBackgroundView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        currentVC?.view.addGestureRecognizer(tap)
        currentVC?.view.isUserInteractionEnabled = true
        let picker = UIDatePicker()
        
        picker.datePickerMode = type
        
        if let min = minDate {
            picker.minimumDate = min
        }
        if let max = maxDate {
            
            if let sDate = selectedDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = DateFormat.ddMMMyy12
                picker.date = dateFormatter.date(from: sDate) ?? max
            } else {
                picker.date = max
            }
            picker.maximumDate = max
        }
        
        picker.backgroundColor = .whiteColor
        picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        currentVC?.view.addSubview(picker)
        setPickerFrame(pickerView: picker, vc: currentVC!)
        sourceVC.present(currentVC!, animated: true, completion: nil)
        completionHandler = { value in
            closure(value)
        }
        
        openPickerView()
        datePickerValueChanged(sender: picker)
    }
    
    @objc static func datePickerValueChanged(sender: UIDatePicker) {
        
        if let handler = CustomPicker.completionHandler {
            
            if sender.datePickerMode == .date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = DateFormat.ddmmyyyy
                let dateString = dateFormatter.string(from: sender.date)
                CustomPicker.selectedValue = dateString
//                handler(dateString)
            } else if sender.datePickerMode == .time {
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                let timeString = formatter.string(from: sender.date)
                handler(timeString)
            }
            else{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = DateFormat.dd_mm_yyyy_hh_mm_ss
                let dateString = dateFormatter.string(from: sender.date)
                CustomPicker.selectedValue = dateString
            }
            
        }
    }
    
    @objc static func handleTap(_ sender: UITapGestureRecognizer) {
        
        //closePickerView()
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    static func setPickerFrame(pickerView: UIView, vc: UIViewController) {
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
        
        pickerConstraints = NSLayoutConstraint(item: pickerView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: vc.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0)
        vc.view.addConstraints([pickerConstraints])
        
        
        dummyBackgroundView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
        dummyBackgroundView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
        dummyBackgroundView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
        dummyBackgroundView.topAnchor.constraint(equalTo: vc.view.topAnchor).isActive = true
        
        
        let barAccessory = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelClick))
        
        
        //  barAccessory.items = [cancelButton, spaceButton, doneButton]
        barAccessory.setItems([cancelButton, spaceButton, doneButton], animated: true)
        barAccessory.translatesAutoresizingMaskIntoConstraints = false
        currentVC?.view.addSubview(barAccessory)
        
        barAccessory.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
        barAccessory.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
        barAccessory.bottomAnchor.constraint(equalTo: pickerView.topAnchor).isActive = true
        barAccessory.heightAnchor.constraint(equalToConstant: 44).isActive = true
        barAccessory.barStyle = .default
    }
    
    @objc static func doneClick() {
        UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            CustomPicker.currentVC?.view.layoutIfNeeded()
            if let handler = CustomPicker.completionHandler,CustomPicker.selectedValue.count > 0 {
                handler(CustomPicker.selectedValue)
            }
        }, completion: { (_) in
            CustomPicker.currentVC?.dismiss(animated: true, completion: nil)
            CustomPicker.selectedValue = ""
        })
    }
    @objc static func cancelClick() {
        CustomPicker.currentVC?.dismiss(animated: true, completion: nil)
        CustomPicker.selectedValue = ""
    }
    
    static func openPickerView() {
        UIView.animate(withDuration: 1.0, delay: 1, options: UIView.AnimationOptions.curveEaseIn, animations: {
            pickerConstraints.constant = 0
            currentVC?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
}


class CustomPickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    var pickerDataSource: [String] = []
    var selectedindex = 0
    
    override init() {
        super.init()
    }
    
    func initWithDataSource(dataSource: [String], sIndex: Int) {
        selectedindex = sIndex
        pickerDataSource = dataSource
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedindex = row
        pickerView.reloadComponent(0)
        CustomPicker.selectedValue = pickerDataSource[selectedindex]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
        
    }
    
}

