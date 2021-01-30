//
//  CountryCodeViewController.swift
//  GoJekProvider
//
//  Created by apple on 19/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class CountryCodeViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var cityListEntity: [City_data] = []
    var countryListEntity: [CountryData] = []
    var pickerType: PickerType = .countryList
    var countryCode: ((Country)->Void)?
    var selectedCountry: ((CountryData)->Void)?
    var selectedCity: ((City_data)->Void)?
    var isSearch = false
    
    // MARK: - LocalVariable
    private var filterCountryCodeList = [Country]() {
        didSet {
            if filterCountryCodeList.count == 0 {
                tableView.setBackgroundImageAndTitle(imageName: LoginConstant.searchImage, title: AccountConstant.countryCodeSearchError, tintColor: .lightGray)
            }else{
                tableView.backgroundView = nil
            }
        }
    }
    
    private var countryCodeList: [Country] = []
    
    var filterCountryListEntity = [CountryData]() {
        didSet {
            if filterCountryListEntity.count == 0 {
                tableView.setBackgroundImageAndTitle(imageName: LoginConstant.searchImage, title: AccountConstant.countrySearchError, tintColor: .lightGray)
            }else{
                tableView.backgroundView = nil
            }
        }
    }
    
    var filterCityListEntity = [City_data]() {
        didSet {
            if filterCityListEntity.count == 0 {
                tableView.setBackgroundImageAndTitle(imageName: LoginConstant.searchImage, title: AccountConstant.citySearchError, tintColor: .lightGray)
            }else{
                tableView.backgroundView = nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.setCustomFont(name: .medium, size: .x22)]
        if CommonFunction.checkisRTL() {
            self.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: Constant.ic_back)?.imageFlippedForRightToLeftLayoutDirection(), style: .plain, target: self, action: #selector(backBarButtonAction))
        }else {
            self.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: Constant.ic_back), style: .plain, target: self, action: #selector(backBarButtonAction))
        }
        self.navigationBar.tintColor = .black
        tableView.backgroundColor = .white
        self.hideTabBar()
        self.view.backgroundColor = .white
        self.tableView.register(nibName: LoginConstant.CountryListCell)
        self.countryCodeList = AppUtils.shared.getCountries()
        searchBar.placeholder = AccountConstant.search.localized
        // self.searchBar.becomeFirstResponder()
        if pickerType  == .cityList {
            self.navigationBar.topItem?.title = AccountConstant.chooseCity.localized
        }else if pickerType == .countryList {
            self.navigationBar.topItem?.title = AccountConstant.chooseCountry.localized
        }else{
            self.navigationBar.topItem?.title = AccountConstant.chooseCountry.localized
        }
        hideKeyboardWhenTappedAround()
    }
    
    @objc func backBarButtonAction() {
        
        if self.parent is UINavigationController{
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.tableView.reloadInMainThread()
        self.navigationController?.isNavigationBarHidden = true
    }
}


//MARK: - UITableViewDataSource

extension CountryCodeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pickerType == .countryCode {
            if checkSearchBarActive() {
                return filterCountryCodeList.count
            }
            return countryCodeList.count
        }else if pickerType == .cityList {
            if checkSearchBarActive() {
                return filterCityListEntity.count
            }
            return cityListEntity.count
        } else{
            if checkSearchBarActive() {
                return filterCountryListEntity.count
            }
            return countryListEntity.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountConstant.CountryListCell, for: indexPath) as! CountryListCell
        cell.countryNameLabel.textAlignment = .center
        if pickerType == .countryCode  {
            if isSearch {
                cell.set(values: filterCountryCodeList[indexPath.row])
                cell.countryNameLabel.textAlignment = .left
            }else{
                cell.set(values: countryCodeList[indexPath.row])
                cell.countryNameLabel.textAlignment = .left
            }
        }else if pickerType == .cityList  {
            if isSearch {
                cell.countryNameLabel.text = filterCityListEntity[indexPath.row].city?.city_name
                cell.countryImageView.isHidden = true
            }else{
                cell.countryNameLabel.text = cityListEntity[indexPath.row].city?.city_name
                cell.countryImageView.isHidden = true
            }
        } else{
            if isSearch {
                cell.countryNameLabel.text = filterCountryListEntity[indexPath.row].country?.country_name
                cell.countryImageView.isHidden = true
            }else{
                cell.countryNameLabel.text = countryListEntity[indexPath.row].country?.country_name
                cell.countryImageView.isHidden = true
            }
        }
        
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension CountryCodeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if pickerType == .countryCode {
            if countryCodeList.count>indexPath.row {
                if isSearch {
                    self.countryCode?(filterCountryCodeList[indexPath.row])
                    
                }else{
                    self.countryCode?(countryCodeList[indexPath.row])
                    
                }
                self.dismiss(animated: true, completion: nil)
            }
        }else if pickerType == .cityList {
            if cityListEntity.count>indexPath.row {
                if isSearch {
                    self.selectedCity?(filterCityListEntity[indexPath.row])
                    
                }else{
                    self.selectedCity?(cityListEntity[indexPath.row])
                    
                }
                self.backBarButtonAction()
            }
        }else{
            if countryListEntity.count>indexPath.row {
                if isSearch {
                    self.selectedCountry?(filterCountryListEntity[indexPath.row])
                    
                }else{
                    self.selectedCountry?(countryListEntity[indexPath.row])
                    
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

//MARK: - UISearchBarDelegate

extension CountryCodeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if pickerType == .countryCode {
            filterCountryCodeList = countryCodeList.filter({ ($0.name+$0.code+$0.dial_code).lowercased().contains(searchText.lowercased())})
            self.tableView.reloadData()
        }else if pickerType == .cityList {
            filterCityListEntity = cityListEntity.filter({ ($0.city?.city_name ?? "").lowercased().contains(searchText.lowercased())})
            self.tableView.reloadData()
        }else{
            filterCountryListEntity = countryListEntity.filter({ ($0.country?.country_name ?? "").lowercased().contains(searchText.lowercased())})
            self.tableView.reloadData()
        }
    }
    
    func checkSearchBarActive() -> Bool {
        if searchBar.isFirstResponder && searchBar.text != "" {
            
            isSearch = true
            return true
        }else {
            isSearch = false
            return false
        }
    }
}
