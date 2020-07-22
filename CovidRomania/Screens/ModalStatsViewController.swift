//
//  ModalStatsViewController.swift
//  CovidRomania
//
//  Created by Radu Nitescu  on 21/07/2020.
//  Copyright © 2020 Radu Nitescu . All rights reserved.
//

import UIKit
import SnapKit
import Charts

class ModalStatsViewController: UIViewController {
    lazy var pieChart: PieChartView! = PieChartView()
    lazy var totalLineChart: LineChartView! = LineChartView()
    
    func pieChartUpdate () {
        let colors: [UIColor] = [
            UIColor(red: 0.575, green: 0.158, blue: 0.158, alpha: 1),
            UIColor(red: 0.201, green: 0.42, blue: 0.531, alpha: 1),
            UIColor(red: 0.758, green: 0.7, blue: 0.392, alpha: 1)
        ]

        let entry = [
            PieChartDataEntry(value: Double(50), label: "Masculin"),
            PieChartDataEntry(value: Double(20), label: "Feminin"),
            PieChartDataEntry(value: Double(20), label: "Copii")
        ]
        
        let dataSet = PieChartDataSet(entries: entry, label: "")
        dataSet.colors = colors
        let data = PieChartData(dataSet: dataSet)
        
        pieChart.data = data

        pieChart.notifyDataSetChanged()
    }
    
    func totalLineChartUpdate() {
        let colors: [UIColor] = [
            .black
        ]
        
        let yValues: [ChartDataEntry] = [
            ChartDataEntry(x: 0, y: 10),
            ChartDataEntry(x: 1, y: 12),
            ChartDataEntry(x: 2, y: 11),
            ChartDataEntry(x: 3, y: 11),
            ChartDataEntry(x: 4, y: 11),
            ChartDataEntry(x: 5, y: 11 ),
            ChartDataEntry(x: 6, y: 14),
            ChartDataEntry(x: 7, y: 13),
            ChartDataEntry(x: 8, y: 12),
            ChartDataEntry(x: 9, y: 12),
            ChartDataEntry(x: 10, y: 12),
            ChartDataEntry(x: 11, y: 12),
            ChartDataEntry(x: 12, y: 12),

        ]
        let dataSet = LineChartDataSet(entries: yValues, label: "Cazuri zilnice de la izbucnirea pandemiei")
        dataSet.mode = .cubicBezier
        dataSet.colors = colors
        dataSet.drawCirclesEnabled = false
        dataSet.setCircleColor(.red)
        dataSet.fill = Fill(color: UIColor(red: 0.575, green: 0.158, blue: 0.158, alpha: 1))
        dataSet.fillAlpha = 0.8
        dataSet.drawFilledEnabled = true
        let data = LineChartData(dataSet: dataSet)
        data.setDrawValues(false)
        totalLineChart.data = data
        totalLineChart.notifyDataSetChanged()
        totalLineChart.animate(xAxisDuration: 0.6)
    }
    
    override func viewDidLoad() {
        var contentHeight = 0
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let scrollView: UIScrollView = {
                 let v = UIScrollView()
                 v.frame = self.view.bounds
                 v.translatesAutoresizingMaskIntoConstraints = false
                 return v
             }()
        self.view.addSubview(scrollView)
        
        self.totalLineChartUpdate()
        scrollView.addSubview(self.totalLineChart)
        self.totalLineChart.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(scrollView.snp.top).offset(60)
            make.width.height.equalTo(UIScreen.main.bounds.width - 24 * 2)
        }
        
        contentHeight += Int(UIScreen.main.bounds.width - 24 * 2 + 60)
        
        self.pieChartUpdate()
        scrollView.addSubview(self.pieChart)
        self.pieChart.snp.makeConstraints { make in
            make.top.equalTo(self.totalLineChart.snp.bottom).offset(100)
            make.centerX.equalTo(scrollView)
            make.width.height.equalTo(self.totalLineChart.snp.width)
        }
        contentHeight += Int(UIScreen.main.bounds.width - 24 * 2 + 100)

        
        scrollView.snp.makeConstraints { make in
            make.center.equalTo(self.view)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(900)
        }
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(contentHeight))

        print(CGFloat(contentHeight))

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
