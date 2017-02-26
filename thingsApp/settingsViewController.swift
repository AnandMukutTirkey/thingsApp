//
//  settingsViewController.swift
//  thingsApp
//
//  Created by Anand Mukut Tirkey on 25/02/17.
//  Copyright © 2017 anand. All rights reserved.
//

import UIKit
import Foundation

var refreshRate = 10
var numberOfResults = 10

class settingsViewController: UIViewController {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var valueLabel2: UILabel!
    @IBOutlet weak var stepper2: UIStepper!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.minimumValue = 1
        stepper2.maximumValue = 50
        stepper.value = Double(refreshRate)
        stepper2.value = Double(numberOfCounts)
    }

    override func viewWillAppear(_ animated: Bool) {
        stepper.value = Double(refreshRate)
        stepper2.value = Double(numberOfCounts)
        stepper.value = Double(refreshRate)
        stepper2.value = Double(numberOfCounts)
        //let timer = Timer.scheduledTimer(timeInterval: TimeInterval(refreshRate), target: self, selector: #selector(adjustmentBestSongBpmHeartRate), userInfo: nil, repeats: true)
        //timer.fire()
    }
    func adjustmentBestSongBpmHeartRate() {
        print("frr")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func stepperAction(_ sender: UIStepper) {
        valueLabel.text = Int(sender.value).description
        refreshRate = Int(sender.value)
    }
    @IBAction func stepper2Action(_ sender: UIStepper) {
        valueLabel2.text = Int(sender.value).description
        numberOfResults = Int(sender.value)
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
func reload1(chID : Int,prKey:String){
    //let numberOfResults = numberOfResults
    //let chID : Int = Int(channelID.text!)!
    //let prKey : String = privateKey.text!
    flag = true
    print(chID)
    var url : NSURL
    if prKey != "" {
        url = NSURL(string: "https://api.thingspeak.com/channels/\(chID)/feeds.json?results=\(numberOfResults)&api_key=\(prKey)")!
    }else{
        url = NSURL(string: "https://api.thingspeak.com/channels/\(chID)/feeds.json?results=\(numberOfResults)")!
    }
    
    print(url)
    let urlRequest = NSMutableURLRequest(url: url as URL)
    let task = URLSession.shared.dataTask(with: url as URL){
        (data, response, error) -> Void in
        if error != nil {
            flag = true
            print("error")
        }else{
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("status code is \(statusCode)")
            
            // if status code is 404 channel doesnot exist
            // if status code is 400 channel is private
            
            if (statusCode == 200) {
                print("file downloaded successfully")
                do{
                    let jsonData  = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    print(jsonData)
                    var count = 0
                    if let details = jsonData["channel"] as? [String:Any]{
                        let name = details["name"] as! String
                        print("fetche name is \(name)")
                        let id = details["id"] as! Int
                        print("fetched id is \(id)")
                        if let temp = details["field8"] as? String{
                            print(temp)
                            count = 8
                        }else if let temp = details["field7"] as? String{
                            count = 7
                        }else if let temp = details["field6"] as? String{
                            count = 6
                        }else if let temp = details["field5"] as? String{
                            count = 5
                        }else if let temp = details["field4"] as? String{
                            count = 4
                        }else if let temp = details["field3"] as? String{
                            count = 3
                        }else if let temp = details["field2"] as? String{
                            count = 2
                        }else if let temp = details["field1"] as? String{
                            count = 1
                        }
                        numberOfCounts = count
                        
                        print("final count is  \(count)")
                        //myChannels.append((name,id))
                        //chaName = name
                        //chaId = id
                        flag = true
                    }
                    field8.removeAll();field7.removeAll();field6.removeAll();field5.removeAll();field4.removeAll();field3.removeAll();field2.removeAll();field1.removeAll();
                    if let feeds = jsonData["feeds"] as? [[String:Any]]{
                        print("----------------------")
                        for feed in feeds{
                            for i in 1...count{
                                let str = "\(i)"
                                let newStr = "field"+str
                                let dat = feed[newStr]
                                print(dat)
                                let d : String = ""
                                var da : Double = 0
                                if let a : String = dat as? String{
                                    if let b = Double(a){
                                        da = b
                                    }else{
                                        break
                                    }
                                    
                                }else{
                                    break
                                }
                                print("\(newStr) has data \(da)")
                                switch i {
                                case 1:
                                    field1.append(da)
                                case 2:
                                    field2.append(da)
                                case 3:
                                    field3.append(da)
                                case 4:
                                    field4.append(da)
                                case 5:
                                    field5.append(da)
                                case 6:
                                    field6.append(da)
                                case 7:
                                    field7.append(da)
                                case 8:
                                    field8.append(da)
                                default:
                                    print("no case matched")
                                    
                                }
                            }
                            let dat = feed["created_at"]
                            let str = dat as? String
                            date.append(str!)
                        }
                    }
                }catch{
                    flag = true
                    print("error try-catch")
                }
            }else{
                flag = true
                print("download filed")
            }
        }
    }
    task.resume()
    
    
    while !flag {
        // busy wait
    }
    /*if let navController = self.navigationController {
     navController.popViewController(animated: true)
     }
     
     print("****************************\(chaName),\(chaId)")
     print(myChannels)
     for (key,value) in myChannels {
     if ((key == chaName as String) && (value == chaId as Int)) {
     print("clone of this channel already exits")
     clonfound = true
     break
     }else{
     //found = true
     }
     }
     if clonfound != true {
     print("clone found is \(clonfound)")
     myChannels.append((chaName,chaId))
     }*/
    
}

