//
//  RevenueController.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit
import Charts

class RevenueController: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var totalRevenueLabel: UILabel!
    @IBOutlet weak var totalRevenueValueLabel: UILabel!
    
    @IBOutlet weak var todayEarningLabel: UILabel!
    @IBOutlet weak var todayEarningValueLabel: UILabel!
    
    @IBOutlet weak var orderReceivedLabel: UILabel!
    @IBOutlet weak var orderReceivedValueLabel: UILabel!
    
    @IBOutlet weak var orderDeliveredLabel: UILabel!
    @IBOutlet weak var orderDeliveredValueLabel: UILabel!
    
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var monthlyEarningLabel: UILabel!
    @IBOutlet weak var monthlyEarningValueLabel: UILabel!
    
    var delivered = [Int]()
    var cancelled = [Int]()
    let xaxisValue: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
    let yaxisValue: [String] = ["0", "100", "200", "300", "400"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initalLoad()
    }
}

//MARK:- ChartViewDelegate

extension RevenueController: ChartViewDelegate {
    
    private func initalLoad(){
        setInitalTitle()
        setFont()
        self.accountPresenter?.revenueList()
        hideTabBar()
        self.title = AccountConstant.revenue
        setLeftBarButtonWith(color: .blackColor)
        setNavigationTitle()
        setColors()
    }
    
    private func setColors(){
        totalRevenueLabel.textColor = .blackColor
        totalRevenueValueLabel.textColor = .appPrimaryColor
        todayEarningLabel.textColor = .blackColor
        todayEarningValueLabel.textColor = .lightGray
        orderReceivedLabel.textColor = .blackColor
        orderReceivedValueLabel.textColor = .lightGray
        orderDeliveredLabel.textColor = .blackColor
        orderDeliveredValueLabel.textColor = .lightGray
        orderLabel.textColor = .appPrimaryColor
        monthlyEarningLabel.textColor = .blackColor
        monthlyEarningValueLabel.textColor = .lightGray
        self.view.backgroundColor = .backgroundColor
        self.topView.backgroundColor = .boxColor
        self.backView.backgroundColor = .boxColor

    }
    
    private func setFont(){
        totalRevenueLabel.font = .setCustomFont(name: .medium, size: .x18)
        totalRevenueValueLabel.font = .setCustomFont(name: .medium, size: .x18)
        todayEarningLabel.font = .setCustomFont(name: .medium, size: .x14)
        todayEarningValueLabel.font = .setCustomFont(name: .medium, size: .x14)
        orderReceivedLabel.font = .setCustomFont(name: .medium, size: .x14)
        orderReceivedValueLabel.font = .setCustomFont(name: .medium, size: .x14)
        orderDeliveredLabel.font = .setCustomFont(name: .medium, size: .x14)
        orderDeliveredValueLabel.font = .setCustomFont(name: .medium, size: .x14)
        orderLabel.font = .setCustomFont(name: .medium, size: .x14)
        monthlyEarningLabel.font = .setCustomFont(name: .medium, size: .x14)
        monthlyEarningValueLabel.font = .setCustomFont(name: .medium, size: .x14)
    }
    
    private func setInitalTitle(){
        orderLabel.text = AccountConstant.order
        totalRevenueLabel.text = AccountConstant.todayRevenue.localized
        todayEarningLabel.text = AccountConstant.totalEarning.localized
        orderReceivedLabel.text = AccountConstant.orderCancelled.localized
        orderDeliveredLabel.text = AccountConstant.orderDelivered.localized
        monthlyEarningLabel.text = AccountConstant.monthlyEarning.localized
    }
    
    func setupView() {
        
        let legend = barChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        legend.textColor = UIColor.lightGray
        
        // Y - Axis Setup
        let yaxis = barChartView.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        yaxis.labelTextColor = UIColor.lightGray
        yaxis.axisLineColor = UIColor.lightGray
        let formatter1 = CustomLabelsXAxisValueFormatter()//custom value formatter
        
        formatter1.labels = self.yaxisValue
        yaxis.valueFormatter = formatter1
        barChartView.rightAxis.enabled = false
        
        // X - Axis Setup
        let xaxis = barChartView.xAxis
        let formatter = CustomLabelsXAxisValueFormatter()//custom value formatter
        formatter.labels = self.xaxisValue
        
        xaxis.valueFormatter = formatter
        xaxis.drawGridLinesEnabled = false
        xaxis.labelPosition = .bottom
        xaxis.labelTextColor = UIColor.lightGray
        xaxis.centerAxisLabelsEnabled = true
        xaxis.axisLineColor = UIColor.lightGray
        xaxis.granularityEnabled = true
        xaxis.enabled = true
        
        barChartView.delegate = self
        barChartView.noDataText = AccountConstant.chartData
        barChartView.noDataTextColor = UIColor.lightGray
        barChartView.chartDescription?.textColor = UIColor.lightGray
        
        setChart()
    }
    
    func setChart() {
        barChartView.noDataText = "Loading...!"
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        
        for i in 0..<self.xaxisValue.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i) , y: Double(truncating: self.delivered[i] as NSNumber))
            dataEntries.append(dataEntry)
            
            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: Double(truncating: self.cancelled[i] as NSNumber))
            dataEntries1.append(dataEntry1)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries1, label: AccountConstant.orderCancelled)
        let chartDataSet1 = BarChartDataSet(entries: dataEntries, label: AccountConstant.orderDelivered)
        
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        chartDataSet.colors = [UIColor.appPrimaryColor]
        chartDataSet1.colors = [UIColor.lightGray]
        
        let chartData = BarChartData(dataSets: dataSets)
        
        let groupSpace = 0.4
        let barSpace = 0.03
        let barWidth = 0.2
        
        chartData.barWidth = barWidth
        
        barChartView.xAxis.axisMinimum = 0.0
        barChartView.xAxis.axisMaximum = 0.0 + chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(self.xaxisValue.count)
        
        chartData.groupBars(fromX: 0.0, groupSpace: groupSpace, barSpace: barSpace)
        
        barChartView.xAxis.granularity = barChartView.xAxis.axisMaximum / Double(self.xaxisValue.count)
        barChartView.data = chartData
        barChartView.notifyDataSetChanged()
        barChartView.setVisibleXRangeMaximum(4)
        barChartView.animate(yAxisDuration: 1.0, easingOption: .linear)
        chartData.setValueTextColor(UIColor.white)
    }
}

//MARK:- AccountPresenterToAccountViewProtocol

extension RevenueController: AccountPresenterToAccountViewProtocol {
    
    func getRevenueSuccess(revenueEntity: RevenueEntity) {
        totalRevenueValueLabel.text = (revenueEntity.responseData?.today_earnings?.total_amount ?? 0).setCurrency()
        todayEarningValueLabel.text = (revenueEntity.responseData?.total_earnings?.total_amount ?? 0).setCurrency()
        orderReceivedValueLabel.text = revenueEntity.responseData?.cancelled_count?.toString()
        orderDeliveredValueLabel.text = revenueEntity.responseData?.delivered_data?.toString()
        monthlyEarningValueLabel.text = (revenueEntity.responseData?.month_earnings?.total_amount ?? 0).setCurrency()
        delivered = revenueEntity.responseData?.completed_data ?? []
        cancelled = revenueEntity.responseData?.cancelled_data ?? []
        self.setupView()
    }
}
