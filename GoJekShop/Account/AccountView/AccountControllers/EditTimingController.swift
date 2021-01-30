
//
//  EditTimingController.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Alamofire
class EditTimingController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editTimeTableView: UITableView!
    @IBOutlet weak var editTimeSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!
    
    var editTimingData: [EditTimingResponseData] = []
    var allDateArray: NSMutableArray = []
    var selectedDayArray: NSMutableArray = []
    var dateArray: NSMutableArray = []
    
    var startTime = ""
    var endTime = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialLoads()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        saveButton.setCornerRadius()
    }
}

//MARK:- LocalMethod

extension EditTimingController {
    
    private func initialLoads() {
        hideTabBar()
        self.title = AccountConstant.editTiming.localized
        setNavigationTitle()
        self.setLeftBarButtonWith(color: .blackColor)
        saveButton.addTarget(self, action: #selector(tapSaveButton), for: .touchUpInside)
        editTimeSwitch.addTarget(self, action: #selector(tapEditSwitch), for: .touchUpInside)
        self.accountPresenter?.getEditTimingList()
        setFont()
        setTitleColor()
        titleLabel.text = AccountConstant.everyDay.localized
        editTimeTableView.register(nibName: AccountConstant.TEditTimingTableViewCell)
        saveButton.setTitle(Constant.SSave.localized, for: .normal)
    }
    
    private func setTitleColor(){
        titleLabel.textColor = .appPrimaryColor
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .appPrimaryColor
    }
    
    private func setFont() {
        titleLabel.font = .setCustomFont(name: .bold, size: .x16)
        saveButton.titleLabel?.font = .setCustomFont(name: .medium, size: .x16)
    }
    
    func setShopTime() {
        
        let tempAllDic = ["name": "Monday",
                          "id": "ALL",
                          "opentime": "00:00",
                          "closetime": "00:00"]
        allDateArray.add(tempAllDic)
        
        for _ in 0..<7 {
            selectedDayArray.add(NSNumber(value: false))
        }
        
        for i in 0..<editTimingData.count {
            
            let result = editTimingData[i]
            
            if let object = result.store_start_time {
                startTime = "\(object)"
            }
            
            if let object = result.store_end_time {
                endTime = "\(object)"
            }
            
            if (result.store_day == "ALL") {
                editTimeSwitch.isOn = true
                var dict: [AnyHashable : Any] = [:]
                if let mutable = allDateArray[i] as? [AnyHashable : Any] {
                    dict = mutable
                }
                dict["name"] = result.store_day
                dict["id"] = result.store_day
                dict["opentime"] = result.store_start_time
                dict["closetime"] = result.store_end_time
                allDateArray[i] = dict
            } else {
                editTimeSwitch.isOn = false
                let tempDic = makeTimeDic(index: i)
                dateArray.add(tempDic)
            }
        }
        
        if(editTimeSwitch.isOn) {
            getDateArr()
        }
        
        editTimeTableView.reloadData()
    }
    
    
    private func getDateArr(){
        for day in 0..<7 {
            let tempDic = makeTimeDic(index: day)
            dateArray.add(tempDic)
            selectedDayArray[day] = NSNumber(value: true)
        }
    }
    
    private func makeTimeDic(index: Int) -> Dictionary<String, String> {
        var tempDic = ["opentime": startTime,
                       "closetime": endTime]
        switch index {
            case 0:
                tempDic["name"] = "Sunday"
                tempDic["id"] = "SUN"
                tempDic["open"] = "hours_opening[SUN]"
                tempDic["close"] = "hours_closing[SUN]"
            case 1:
                tempDic["name"] = "Monday"
                tempDic["id"] = "MON"
                tempDic["open"] = "hours_opening[MON]"
                tempDic["close"] = "hours_closing[MON]"
            case 2:
                tempDic["name"] = "Tuesday"
                tempDic["id"] = "TUE"
                tempDic["open"] = "hours_opening[TUE]"
                tempDic["close"] = "hours_closing[TUE]"
            case 3:
                tempDic["name"] = "Wednesday"
                tempDic["id"] = "WED"
                tempDic["open"] = "hours_opening[WED]"
                tempDic["close"] = "hours_closing[WED]"
            case 4:
                tempDic["name"] = "Thursday"
                tempDic["id"] = "THUR"
                
                tempDic["open"] = "hours_opening[THUR]"
                tempDic["close"] = "hours_closing[THUR]"
            case 5:
                tempDic["name"] = "Friday"
                tempDic["id"] = "FRI"
                
                tempDic["open"] = "hours_opening[FRI]"
                tempDic["close"] = "hours_closing[FRI]"
            case 6:
                tempDic["name"] = "Saturday"
                tempDic["id"] = "SAT"
                tempDic["open"] = "hours_opening[SAT]"
                tempDic["close"] = "hours_closing[SAT]"
            default:
                break
        }
        return tempDic
    }
    
    private func setTimeValuesFromPicker(selectedIndex: Int, isopen: Int, values: String){
        let cell = self.editTimeTableView.cellForRow(at: IndexPath(row: selectedIndex, section: 0)) as! EditTimingTableViewCell
        if isopen == 1 {
            cell.openTimeValueLabel.text = values
        }else{
            cell.closeTimeValueLabel.text = values
            
        }
        
        if self.editTimeSwitch.isOn {
            for i in 0..<allDateArray.count {
                var dict: [AnyHashable : Any] = [:]
                if let mutable = allDateArray[i] as? [String: String] {
                    dict = mutable
                }
                dict["name"] = "ALL"
                dict["id"] = "ALL"
                dict["opentime"] = cell.openTimeValueLabel.text
                dict["closetime"] = cell.closeTimeValueLabel.text
                allDateArray[i] = dict
            }
        }else {
            for day in 0..<self.dateArray.count {
                var tempDic: [String: String] = [:]
                
                let result = self.dateArray[day] as! NSDictionary
                if let mutable = dateArray[day] as? [String : String] {
                    tempDic = mutable
                }
                
                if day == selectedIndex {
                    tempDic["name"] = result.value(forKey: "name") as? String ?? ""
                    tempDic["id"] = result.value(forKey: "id") as? String ?? ""
                    tempDic["open"] = result.value(forKey: "open") as? String ?? ""
                    tempDic["close"] = result.value(forKey: "close") as? String ?? ""
                    tempDic["opentime"] = cell.openTimeValueLabel.text
                    tempDic["closetime"] = cell.closeTimeValueLabel.text
                }
                dateArray[day] = tempDic
            }
        }
    }
}

//MARK:- IBAction

extension EditTimingController {
    
    
    @objc func tapEditSwitch(){
        
        editTimeTableView.reloadData()
    }
    
    @objc func tapSaveButton() {
        
        if (editTimeSwitch.isOn) {
            
            var closeTime = ""
            var openTime = ""
            for i in 0..<allDateArray.count {
                let Result = self.allDateArray[i] as! NSDictionary
                closeTime =  Result.value(forKey: "closetime") as? String ?? ""
                openTime =  Result.value(forKey: "opentime") as? String ?? ""
            }
            
            let param:Parameters = ["day": ["ALL"],
                                    "hours_opening": ["ALL":openTime],
                                    "hours_closing": ["ALL": closeTime],
                                    AccountConstant.PMethod:ProductConstant.PPatch]
            self.accountPresenter?.editTiming(param: param)
            
        } else {
            
            let dayArray: [String] = ["SUN","MON","TUE","WED","THU","FRI","SAT"]
            let openingArray: NSMutableArray = []
            let closingArray: NSMutableArray = []
            
            for i in 0..<dateArray.count {
                let Result = self.dateArray[i] as! NSDictionary
                let openTime =  Result.value(forKey: "opentime") as? String ?? ""
                let closeTime =  Result.value(forKey: "closetime") as? String ?? ""
                openingArray.add(openTime)
                closingArray.add(closeTime)
            }
            
            let param:Parameters = ["day": dayArray,
                                    "hours_opening": ["SUN": openingArray[0],
                                                      "MON": openingArray[1],
                                                      "TUE": openingArray[2],
                                                      "WED": openingArray[3],
                                                      "THU": openingArray[4],
                                                      "FRI": openingArray[5],
                                                      "SAT": openingArray[6]],
                                    "hours_closing": ["SUN": closingArray[0],
                                                      "MON": closingArray[1],
                                                      "TUE": closingArray[2],
                                                      "WED": closingArray[3],
                                                      "THU": closingArray[4],
                                                      "FRI": closingArray[5],
                                                      "SAT": closingArray[6]],
                                    AccountConstant.PMethod:ProductConstant.PPatch]
            self.accountPresenter?.editTiming(param: param)
        }
    }
    
    @objc func openTimebtnAction(sender: UIButton!) {
        
        PickerManager.shared.showTimePicker(selectedDate: nil) { (data) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            let date = dateFormatter.date(from: data)
            
            dateFormatter.dateFormat = "HH:mm"
            let date24 = dateFormatter.string(from: date!)
            self.setTimeValuesFromPicker(selectedIndex: sender?.tag ?? 0,isopen: 1,values: date24)
        }
    }
    
    @objc func closeTimebtnAction(sender: UIButton!) {
        
        PickerManager.shared.showTimePicker(selectedDate: nil) { (data) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            let date = dateFormatter.date(from: data)
            
            dateFormatter.dateFormat = "HH:mm"
            let date24 = dateFormatter.string(from: date!)
            self.setTimeValuesFromPicker(selectedIndex: sender?.tag ?? 0,isopen: 0,values: date24)
        }
    }
}

//MARK:- UITableViewDataSource

extension EditTimingController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if editTimeSwitch.isOn {
            return allDateArray.count
        }else {
            return dateArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountConstant.TEditTimingTableViewCell, for: indexPath) as! EditTimingTableViewCell
        if editTimeSwitch.isOn {
            let result = allDateArray[indexPath.row] as! NSDictionary
            cell.openTimeValueLabel.text = result.value(forKey: "opentime") as? String ?? "00:00"
            cell.closeTimeValueLabel.text = result.value(forKey: "closetime") as? String ?? "00:00"
            cell.topTitleView.isHidden = true
            
            cell.openButton.addTarget(self, action: #selector(self.openTimebtnAction), for: .touchUpInside)
            cell.closeButton.addTarget(self, action: #selector(self.closeTimebtnAction), for: .touchUpInside)
            
        } else{
            
            let result = dateArray[indexPath.row] as! NSDictionary
            cell.dayLabel.text = result.value(forKey: "name") as? String ?? ""
            cell.openTimeValueLabel.text = result.value(forKey: "opentime") as? String ?? "00:00"
            cell.closeTimeValueLabel.text = result.value(forKey: "closetime") as? String ?? "00:00"
            cell.topTitleView.isHidden = false
            
            cell.openButton.addTarget(self, action: #selector(self.openTimebtnAction), for: .touchUpInside)
            cell.closeButton.addTarget(self, action: #selector(self.closeTimebtnAction), for: .touchUpInside)
        }
        cell.openButton.tag = indexPath.row
        cell.closeButton.tag = indexPath.row
        
        return cell
    }
}

//MARK:- UITableViewDelegate

extension EditTimingController: UITableViewDelegate {
    
}

//MARK:- AccountPresenterToAccountViewProtocol

extension EditTimingController: AccountPresenterToAccountViewProtocol {
    
    func getEditTimingSuccess(editTimingEntity: EditTimingEntity) {
        
        editTimingData = editTimingEntity.responseData ?? []
        setShopTime()
    }
    
    func editTimingSuccess(editTimingEntity: CreateAddonsEntity) {
        ToastManager.show(title: editTimingEntity.message ?? "", state: .success)
               self.navigationController?.popViewController(animated: true)
    }
}
