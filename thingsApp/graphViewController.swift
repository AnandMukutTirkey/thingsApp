//
//  graphViewController.swift
//  thingsApp
//
//  Created by Anand Mukut Tirkey on 25/02/17.
//  Copyright © 2017 anand. All rights reserved.
//

import UIKit
import Charts

class graphViewController: UIViewController,ChartViewDelegate {

    
    @IBOutlet weak var cchart: LineChartView!
    
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var avgLevel: UILabel!
    @IBOutlet weak var maxLevel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        minLabel.text = "min \(Int(month.min()!))"
        maxLevel.text = "max \(Int(month.max()!))"
        var sum = 0
        for i in month{
            sum += Int(i)
        }
        avgLevel.text = "avg \(sum/month.count)"
        
        let formato : BarCHartFormatter = BarCHartFormatter()
        let xaxis = XAxis()
        
        // 1 - creating an array of data entries
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0 ..< month.count {
            yVals1.append(ChartDataEntry(x: Double(i), y: month[i]))
            
            //yVals1.append(ChartDataEntr)
        }
        let set1: LineChartDataSet = LineChartDataSet(values: yVals1, label: "First Set")
        set1.axisDependency = .left // Line will correlate with left axis values
        set1.setColor(UIColor.red.withAlphaComponent(0.5)) // our line's opacity is 50%
        set1.setCircleColor(UIColor.red) // our circle will be dark red
        set1.lineWidth = 2.0
        set1.circleRadius = 6.0 // the radius of the node circle
        set1.fillAlpha = 65 / 255.0
        set1.fillColor = UIColor.red
        set1.highlightColor = UIColor.white
        set1.drawCircleHoleEnabled = true
        
        //3 - create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        
        //4 - pass our months in for our x-axis label value along with our dataSets
        //let data: LineChartData = LineChartData(xVals: months, dataSets: dataSets)
        let data = LineChartData()
        let dataset = LineChartDataSet(values: yVals1, label: "Hello")
        dataset.colors = [NSUIColor.red]
        data.addDataSet(dataset)
        data.setValueTextColor(UIColor.white)
        
        //5 - finally set our data
        cchart?.data = data
        
        cchart?.gridBackgroundColor = NSUIColor.white
        cchart?.xAxis.drawGridLinesEnabled = false;
        cchart?.xAxis.labelPosition = XAxis.LabelPosition.bottom
        cchart?.chartDescription?.text = "LineChartView Example"
        cchart?.xAxis.valueFormatter = IndexAxisValueFormatter(values: date)
        cchart?.xAxis.granularity = 1
        cchart?.xAxis.labelRotationAngle = 90

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
