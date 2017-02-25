//
//  ViewController.swift
//  thingsApp
//
//  Created by Anand Mukut Tirkey on 25/02/17.
//  Copyright © 2017 anand. All rights reserved.
//

import UIKit

var numberOfCounts = 0
var field1 = [Double]()
var field2 = [Double]()
var field3 = [Double]()
var field4 = [Double]()
var field5 = [Double]()
var field6 = [Double]()
var field7 = [Double]()
var field8 = [Double]()



class ViewController: UIViewController {

    @IBOutlet weak var channelID: UITextField!
    @IBOutlet weak var privateKey: UITextField!
    @IBOutlet weak var mySwitch: UISwitch!
    
    var flag = false
    var chaName : String = ""
    var chaId : Int = 0
    var clonfound = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveAndUpdate(_ sender: UIBarButtonItem) {
        
        let numberOfResults = 10
        let chID : Int = Int(channelID.text!)!
        let prKey : String = privateKey.text!
        print(chID)
        var url : NSURL
        if mySwitch.isOn {
            url = NSURL(string: "https://api.thingspeak.com/channels/\(chID)/feeds.json?results=\(numberOfResults)&api_key=\(prKey)")!
        }else{
            url = NSURL(string: "https://api.thingspeak.com/channels/\(chID)/feeds.json?results=\(numberOfResults)")!
        }
        
        print(url)
        let urlRequest = NSMutableURLRequest(url: url as URL)
        let task = URLSession.shared.dataTask(with: url as URL){
            (data, response, error) -> Void in
            if error != nil {
                self.flag = true
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
                                count += 8
                            }else if let temp = details["field7"] as? String{
                                count += 7
                            }else if let temp = details["field6"] as? String{
                                count += 6
                            }else if let temp = details["field5"] as? String{
                                count += 5
                            }else if let temp = details["field4"] as? String{
                                count += 4
                            }else if let temp = details["field3"] as? String{
                                count += 3
                            }else if let temp = details["field2"] as? String{
                                count += 2
                            }else if let temp = details["field1"] as? String{
                                count += 1
                            }
                            numberOfCounts = count
                            
                            print("final count is  \(count)")
                            myChannels.append((name,id))
                            self.chaName = name
                            self.chaId = id
                            self.flag = true
                        }
                        if let feeds = jsonData["feeds"] as? [[String:Any]]{
                            print("----------------------")
                            for feed in feeds{
                                for i in 1...count{
                                    let str = "\(i)"
                                    let newStr = "field"+str
                                    let dat = feed[newStr]
                                    print(dat)
                                    let d : String = dat as! String
                                    let da : Double = Double(d)!
                                    //let da = Double(dat!)
                                    //let da : Double = 0
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
                            }
                        }
                    }catch{
                        self.flag = true
                        print("error try-catch")
                    }
                }else{
                    self.flag = true
                    print("download filed")
                }
            }
        }
        task.resume()
        
        
        while !flag {
            // busy wait
        }
        if let navController = self.navigationController {
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
        }
    }

    @IBAction func switchOn(_ sender: UISwitch) {
        if privateKey.isHidden{
            privateKey.isHidden = false
        }else{
            privateKey.isHidden = true
        }
    }
    

}

