//
//  BatchHealthGraphVC.swift
//  Batch
//
//  Created by Vijay Singh on 21/03/24.
//

import UIKit
import DGCharts

class BatchHealthGraphVC: UIViewController,AxisValueFormatter {

    @IBOutlet weak var barChartVIew: BarChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var monthDurationBtn: UIButton!
    @IBOutlet weak var weekDurationBtn: UIButton!
    @IBOutlet weak var dayDurationBtn: UIButton!
    @IBOutlet weak var averageDataLabel: UILabel!
    @IBOutlet weak var averageTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var graphTypeLabel: UILabel!
    
    private var headingTitle = ["Range", "Averag:","Average Bedtime","Average Calories",""]
    var type = 0
    var pieValue: [Double] = [67, 100]
    var graphValue: [Double] = [1.0,2.0,3.0,4.0,5.0,6.0,7.0,8,9,10,11,12,13,14]
    var axisValue: [String] = ["1.0","2.0","3.0","4.0","5.0","6.0","7.0","8.0","9.0","10.0","11.0","12.0","13.0","14.0"]
    weak var axisFormatDelegate: AxisValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupInitialView()
    }
    
    private func setupInitialView(){
        self.axisFormatDelegate = self
        barChartVIew.isHidden = true
        lineChartView.isHidden = true
        pieChartView.isHidden = false
        monthDurationBtn.isSelected = false
        weekDurationBtn.isSelected = false
        dayDurationBtn.isSelected = true
        updatePieChart(pieChartView: pieChartView)
    }
    
    @IBAction func dismissViewBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func durationButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.tag{
        case 0:
            updatePieChart(pieChartView: pieChartView)
            barChartVIew.isHidden = true
            lineChartView.isHidden = true
            pieChartView.isHidden = false
            monthDurationBtn.isSelected = false
            weekDurationBtn.isSelected = false
            dayDurationBtn.isSelected = true
        case 1:
            barChartVIew.isHidden = false
            lineChartView.isHidden = true
            pieChartView.isHidden = true
            monthDurationBtn.isSelected = false
            weekDurationBtn.isSelected = true
            dayDurationBtn.isSelected = false
            updateBarChart(barChartView: barChartVIew)
        case 2:
            barChartVIew.isHidden = true
            lineChartView.isHidden = false
            pieChartView.isHidden = true
            monthDurationBtn.isSelected = true
            weekDurationBtn.isSelected = false
            dayDurationBtn.isSelected = false
            updateLineChart(lineChartView: lineChartView)
        default:
            break
        }
    }
    
    func updateLineChart(lineChartView: LineChartView){
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<(self.graphValue.count ){
            let lineChart = ChartDataEntry(x: Double(i), y:Double(self.graphValue[i] ))
            lineChartEntry.append(lineChart)
        }
        let l1 = LineChartDataSet(entries: lineChartEntry)
        let col = UIColor.init(named: "AppThemeButtonColor") ?? UIColor.black
        l1.colors = [col]
        l1.drawCirclesEnabled = false
        l1.lineWidth = 4
        l1.lineCapType = .round
        
        
        let chartData = LineChartData(dataSet: l1)
        chartData.setDrawValues(false)
        
        lineChartView.data = chartData
    
        lineChartView.legend.enabled = false
    
        lineChartView.rightAxis.enabled = true
        lineChartView.rightAxis.axisLineWidth = 0
        lineChartView.rightAxis.gridLineWidth = 0
        lineChartView.rightAxis.labelAlignment = .center
        lineChartView.leftAxis.enabled = false
        lineChartView.drawBordersEnabled = false
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.extraRightOffset = 10
        lineChartView.extraLeftOffset = 10
        lineChartView.xAxis.avoidFirstLastClippingEnabled = false
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.granularityEnabled = false
        lineChartView.xAxis.granularity = 0
        lineChartView.xAxis.forceLabelsEnabled = false
        let xAxisValue = lineChartView.xAxis
        xAxisValue.valueFormatter = axisFormatDelegate
        lineChartView.fitScreen()
    }
    
    func updateBarChart(barChartView: BarChartView){
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<(self.graphValue.count ){
            let lineChart = BarChartDataEntry(x: Double(i), y:Double(self.graphValue[i] ))
            lineChartEntry.append(lineChart)
        }
        let l1 = BarChartDataSet(entries: lineChartEntry)
        let col = UIColor.init(named: "AppThemeButtonColor") ?? UIColor.black
        l1.colors = [col]
        
        /**
         to make bar-chart bar rounded need to make changes in pod of Charts
         Find BarChartRenderer.swift
                and then find method open func drawDataSet
                    
                replace this code:-
                    context.fill(barRect)
                with the code :-
                    let bezierPath = UIBezierPath(roundedRect: barRect, cornerRadius: %YOUR_CORNER_RADIUS%)
                    context.addPath(bezierPath.cgPath)
                    context.drawPath(using: .fill)
         
            on the line 382
         **/
        
        
        let chartData = BarChartData(dataSet: l1)
        chartData.setDrawValues(false)
        chartData.barWidth = 0.2
        
        barChartView.data = chartData
    
        barChartView.legend.enabled = false
        barChartView.rightAxis.enabled = true
        barChartView.rightAxis.axisLineWidth = 0
        barChartView.rightAxis.gridLineWidth = 0
        barChartView.rightAxis.labelAlignment = .center
        barChartView.leftAxis.enabled = false
        barChartView.drawBordersEnabled = false
        barChartView.drawGridBackgroundEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.forceLabelsEnabled = false
        barChartView.xAxis.labelPosition = .bottom
        let xAxisValue = barChartView.xAxis
        xAxisValue.valueFormatter = axisFormatDelegate
        barChartView.fitScreen()
    }
    
    func updatePieChart(pieChartView: PieChartView){
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<(self.pieValue.count ){
            let lineChart = ChartDataEntry(x: Double(i), y:Double(self.pieValue[i] ))
            lineChartEntry.append(lineChart)
        }
        let l1 = PieChartDataSet(entries: lineChartEntry)
        let col = UIColor.init(named: "AppThemeButtonColor") ?? UIColor.black
        l1.colors = [col, UIColor.black]
        l1.sliceSpace = 2
        let chartData = PieChartData(dataSet: l1)
        chartData.setDrawValues(false)
        pieChartView.data = chartData
        pieChartView.drawCenterTextEnabled = true
       
        let centerString = "7h58m"
        let col1 = UIColor.init(hex: "101215") ?? UIColor.black
        let myAttribute = [NSAttributedString.Key.font: UIFont(name: "Outfit-Medium", size: 24.0)!, NSAttributedString.Key.foregroundColor: col1]
        let myAttrString = NSAttributedString(string: centerString, attributes: myAttribute)
        pieChartView.centerAttributedText = myAttrString
        pieChartView.holeRadiusPercent = 0.85
        pieChartView.transparentCircleRadiusPercent = 0
        pieChartView.legend.enabled = false
        pieChartView.chartDescription.enabled = false
        pieChartView.minOffset = 0
    
        pieChartView.legend.enabled = false
    }
    
    func stringForValue(_ value: Double, axis: DGCharts.AxisBase?) -> String {
        return axisValue[Int(value)]
    }
    
}
