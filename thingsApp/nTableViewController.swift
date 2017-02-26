//
//  nTableViewController.swift
//  thingsApp
//
//  Created by Anand Mukut Tirkey on 25/02/17.
//  Copyright © 2017 anand. All rights reserved.
//

import UIKit
import Charts

var month = [Double]()
@objc(BarChartFormatter)
public class BarCHartFormatter : NSObject,IAxisValueFormatter{
    var month = ["Janu" , "Feb", "Mar", "Apr", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec"]
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return month[Int(value)]
    }
}

class custommCell: UITableViewCell {
    @IBOutlet weak var nField: UILabel!
    @IBOutlet weak var nChart: LineChartView!
    @IBOutlet weak var nMin: UILabel!
    @IBOutlet weak var nAverage: UILabel!
    @IBOutlet weak var nMax: UILabel!
}

class nTableViewController: UITableViewController,ChartViewDelegate {
    var cellCount = 0
    //var cell : UITableViewCell?
    var count = 1
    let temp = ["","","","","","","","","",""]
    override func viewDidLoad() {
        super.viewDidLoad()
        print("i am here")
        print(field1)
        print(field2)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numberOfCounts
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("i am here")
        print(field1)
        print(field2)
        count = 1
        tableView.reloadData()
        //let timer = Timer.scheduledTimer(timeInterval: TimeInterval(refreshRate), target: self, selector: #selector(adjustmentBestSongBpmHeartRate), userInfo: nil, repeats: true)
        //timer.fire()
    }
    func adjustmentBestSongBpmHeartRate() {
        //print("frr")
        //self.tableView.reloadData()
        //reload1(chID: currentChannelID, prKey: currentPrivateKey)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! custommCell
        
        var month = field8
        let lineChart = cell.nChart
        switch count {
        case 1:
            month = field1
        case 2:
            month = field2
        case 3:
            month = field3
        case 4:
            month = field4
        case 5:
            month = field5
        case 6:
            month = field6
        case 7:
            month = field7
        case 8:
            month = field8
        default:
            print("i don't know")
        }
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
        lineChart?.data = data
        
        lineChart?.gridBackgroundColor = NSUIColor.white
        lineChart?.xAxis.drawGridLinesEnabled = false;
        lineChart?.xAxis.labelPosition = XAxis.LabelPosition.bottom
        lineChart?.chartDescription?.text = "LineChartView Example"
        lineChart?.xAxis.valueFormatter = IndexAxisValueFormatter(values: temp)
        lineChart?.xAxis.granularity = 1
        lineChart?.xAxis.labelRotationAngle = 90
        
        cell.nField.text = "field \(count)";//count = (count += 1) % numberOfCounts
        count += 1
        //count %= numberOfCounts

        cell.nMin.text = date[0]
        cell.nMax.text = date[9]
        

        // Configure the cell...

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "graph")
        print("============================index path\(indexPath.row+1)")
        switch indexPath.row+1 {
        case 1:
            month = field1
        case 2:
            month = field2
        case 3:
            month = field3
        case 4:
            month = field4
        case 5:
            month = field5
        case 6:
            month = field6
        case 7:
            month = field7
        case 8:
            month = field8
        default:
            print("i don't know")
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
