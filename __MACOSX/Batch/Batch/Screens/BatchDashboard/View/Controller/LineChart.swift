////
////  LineChart.swift
////  Batch
////
////  Created by Vijay Singh on 09/03/24.
////
//
//import Foundation
//import UIKit
//import DGCharts
//
//class LineChart: UIView{
//    // Line graph properties
//    let lineChartView = LineChartView()
//    var lineDataEntry: [ChartDataEntry] = []
//    // Chart data
//    var workoutDuration = [String]()
//    var beatsPerMinute = [String]()
//    var delegate: GetChartData! {
//        didSet { 
//            populateData ()
//            lineChartSetup ()
//        }
//    }
//    func populateData() {
//        workoutDuration = delegate.workoutDuration
//        beatsPerMinute = delegate.beatsPerMinute
//    }
//    
//    func lineChartSetup() {
//        // Line chart config
//        self.backgroundColor = UIColor.white
//        self.addSubview(lineChartView)
//        lineChartView.translatesAutoresizingMaskIntoConstraints = false
//        lineChartView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive =
//        true
//        lineChartView.bottomAnchor.constraint (equalTo: self.bottomAnchor).isActive = true
//        lineChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        lineChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        // Line chart animation
//        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInSine)
//        // Line chart population
//        setLineChart(dataPoints: workoutDuration, values: beatsPerMinute)
//    }
//    
//    func setLineChart(dataPoints: [String], values: [String]){
//    // No data setup
//    lineChartView.noDataTextColor = UIColor.white
//    lineChartView.noDataText = "No data for the chart."
//    lineChartView.backgroundColor = UIColor.white
//    // Data point setup & color config
//        for i in 0..<dataPoints.count{
//            let dataPoint = ChartDataEntry(x: Double(i), y: Double(values[i])!)
//            lineDataEntry.append(dataPoint)
//        }
//        let chartDataSet = LineChartDataSet(entries: lineDataEntry, label: "BPM")
//    let chartData = LineChartData()
//    chartData.addDataSet(chartDataSet)
//    chartData.setDrawValues(true) // false if don't want values above bar
//    chartDataSet.colors = [UIColor.systemPink]
//    chartDataSet.setCircleColor(UIColor.systemPink)
//    chartDataSet.circleHoleColor = UIColor.systemPink
//    chartDataSet.circleRadius = 4.0
//
//    // Axes setup
//    let formatter = ChartFormatter()
//    formatter.setValues(values: dataPoints)
//        
//    let xaxis: XAxis = XAxis()
//    xaxis.valueFormatter = formatter
//    lineChartView.xAxis.labelPosition = .bottom
//    lineChartView.xAxis.drawGridLinesEnabled = false // true if want X-Axis grid lines
//    lineChartView.xAxis.valueFormatter = xaxis.valueFormatter
//        lineChartView.chartDescription.enabled = false
//    lineChartView.legend.enabled = true
//    lineChartView.rightAxis.enabled = false
//    lineChartView.leftAxis.drawGridLinesEnabled = false // true if want Y-Axis grid
//    lineChartView.leftAxis.drawLabelsEnabled = true
//    lineChartView.data = chartData
//    }
//}
