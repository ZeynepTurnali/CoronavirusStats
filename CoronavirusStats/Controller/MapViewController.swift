//
//  MapViewController.swift
//  CoronavirusStats


import UIKit
import Charts

class MapViewController: UIViewController {
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var fromSevenDeathsVariable = [Int]()
    
    let players = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5", "Day 6", "Day 7"]
    
    var worldDataDetailViewController = WorldDataDetailViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        barChartView.animate(yAxisDuration: 2.0)
        barChartView.pinchZoomEnabled = false
        barChartView.drawBarShadowEnabled = false
        barChartView.drawBordersEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.drawGridBackgroundEnabled = true
        barChartView.chartDescription?.text = "For Seven Day Death Numbers"
        
        setChart(dataPoints: players, values: fromSevenDeathsVariable.map { Int(Double($0))})
        
        
    }
    
    func setChart(dataPoints: [String], values: [Int]) {
        if fromSevenDeathsVariable.count == 7 {
            barChartView.noDataText = "You need to provide data for the chart."
            
            var dataEntries: [BarChartDataEntry] = []
            
            for i in 0..<dataPoints.count {
                let dataEntry = BarChartDataEntry(x: Double(i), y: Double(Int(values[i])))
                dataEntries.append(dataEntry)
            }
            
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
            let chartData = BarChartData(dataSet: chartDataSet)
            barChartView.data = chartData
            barChartView.backgroundColor = .gray
            chartDataSet.colors = [UIColor(red: 0.39, green: 0.07, blue: 0.13, alpha: 1.00)]
        } else {
            worldDataDetailViewController.makeAlert(alertTitle: "Sorry", alertMessage: "We do not have data for the graph")
            
        }
        
    }
}


