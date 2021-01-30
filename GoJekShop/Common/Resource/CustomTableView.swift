//
//  CustomTableView.swift
//  GoJekUser
//
//  Created by Ansar on 22/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class CustomTableView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet private weak var headingLabel: UILabel!
    
    var values: [String] = [] {
        didSet {
            self.tableView.reloadInMainThread()
        }
    }
    
    var textView:UITextView?
    var onClickClose: (()->Void)?
    var selectedItem: ((String)->Void)?
    
    var heading:String = "" {
        didSet {
            headingLabel.text = heading
        }
    }
    
    private var isShowTextView = false {
        didSet {
            tableView.tableFooterView = isShowTextView ? self.getTextView() : nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        self.closeButton.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
        self.tableView.register(nibName: Constant.CustomTableCell)
    }
   
    @objc func tapClose() {
        self.onClickClose!()
    }
    
    // MARK:- Creating Dynamic Text View
    private func getTextView()->UIView{
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 100))
        textView = UITextView(frame: CGRect(x: 16, y: 8, width: self.frame.width-32, height: (self.frame.height/2.5)))
        textView?.enablesReturnKeyAutomatically = true
        textView?.delegate = self
        textView?.layer.borderWidth = 1
        textView?.cornerRadius = 10
        textView?.layer.borderColor = UIColor.lightGray.cgColor
        textView?.backgroundColor = .veryLightGray
        textView?.textColor = .lightGray
        textView?.text = Constant.writingSomething.localized
        textView?.returnKeyType = .send
        view.addSubview(textView!)
        return view
    }
}


//MARK: - UITableViewDataSource

extension CustomTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CustomTableCell, for: indexPath) as! CustomTableCell
        if values.count>indexPath.row {
            cell.contentLabel.text = values[indexPath.row]
        }
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension CustomTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if values.count>indexPath.row {
            if values[indexPath.row] == Constant.other {
                isShowTextView = true
            }else{
               self.selectedItem!(values[indexPath.row])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension CustomTableView: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == Constant.writingSomething.localized {
            textView.text = .empty
            textView.textColor = .black
        }
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text == .empty {
            self.textView?.text = Constant.writingSomething.localized
            self.textView?.textColor = .lightGray
        }
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            self.selectedItem!(textView.text)
        }
        return true
    }
}
