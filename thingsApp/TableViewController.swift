//
//  TableViewController.swift
//  thingsApp
//
//  Created by Anand Mukut Tirkey on 25/02/17.
//  Copyright © 2017 anand. All rights reserved.
//

import UIKit
var myChannels = [(String,Int,String)]()
var currentChannelID = myChannels[0].1
var currentPrivateKey = myChannels[0].2

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        myChannels.append(("my_house",9,""))
        myChannels.append(("ESP8266 DHT11 meteostation in my room",182278,""))

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
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        //let timer = Timer.scheduledTimer(timeInterval: TimeInterval(refreshRate), target: self, selector: #selector(adjustmentBestSongBpmHeartRate), userInfo: nil, repeats: true)
        //timer.fire()
    }
    func adjustmentBestSongBpmHeartRate() {
        //print("frr")
        
        //reload1(chID: currentChannelID, prKey: currentPrivateKey)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(myChannels[indexPath.row].0) \(myChannels[indexPath.row].1)"
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myChannels.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentChannelID = myChannels[indexPath.row].1
        print("************reloading \(currentChannelID) and \(myChannels[indexPath.row].2)")
        reload(chID: currentChannelID, prKey: myChannels[indexPath.row].2)
        let vc = storyboard?.instantiateViewController(withIdentifier: "tabu")
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        myChannels.remove(at: indexPath.row)
        self.tableView.reloadData()
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
