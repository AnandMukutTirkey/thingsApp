//
//  loginViewController.swift
//  thingsApp
//
//  Created by Anand Mukut Tirkey on 25/02/17.
//  Copyright © 2017 anand. All rights reserved.
//

import UIKit
var userNameList = [String]()
var passwordList = [String]()
var phoneNumberList  = [Int64]()

class loginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let a : String = "anand"
        let b : String = "mukut"
        let c : Int64 = 9694609058
        
        userNameList.append(a)
        passwordList.append(b)
        phoneNumberList.append(c)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        //let userData : [String] = UserDefaults.standard.array(forKey:"username") as! [String]
        //let passwordData : [String] = UserDefaults.standard.array(forKey : "password") as! [String]
        /*for i in 0..<userData.count{
            print("\(userName.text) and \(userData[i])")
            let temp1 : String = userData[i]
            let temp2 : String = userName.text!
            print("\(temp1) and \(temp2)")
            if !(temp1 !~= temp2) {
                print("username fount")
                if password.text == passwordData[i] {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
                    present(vc!, animated: true, completion: nil)
                }else{
                    let alertController = UIAlertController(title: "error", message: "wrong password", preferredStyle: .alert)
                    let tryAction = UIAlertAction(title: "Try Again", style: .cancel) { (_) in }
                    alertController.addAction(tryAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }*/
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
        present(vc!, animated: true, completion: nil)
    }

    @IBAction func signUpAction(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "signup")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
     @IBAction func forgotAction(_ sender: UIButton) {
        let userData : [String] = UserDefaults.standard.array(forKey:"username") as! [String]
        let phoneData = UserDefaults.standard.array(forKey: "phonenumber") as! [Int]
        print("retrieved data \(userData) \(phoneData)")
        for i in 0..<userData.count{
            let temp1 : String = userData[i]
            //let temp1 : String = temp!
            let temp2 : String = userName.text!
            print("\(temp1) and \(temp2)")
            if true {
                print("username fount")
                let phone = phoneNumberList[i]
                //if Int(mobileNumber.text!)! == Int(phoneData[i]) {
                    print("phone number found")
                    let random = arc4random_uniform(10000)
                    let randomNumber : Int = Int(random)
                    let number : Int = Int(phone)
                    var url : NSURL
                    url = NSURL(string: "http://sms.dataoxytech.com/index.php/smsapi/httpapi/?uname=sylvester007&password=forskmnit&sender=FORSKT&receiver=\(number)&route=TA&msgtype=1&sms=\(randomNumber)")!
                    print(url)
                    let task = URLSession.shared.dataTask(with: url as URL) {(data, response, error) in
                        //print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
                    }
                    task.resume()
                    let vc = storyboard?.instantiateViewController(withIdentifier: "forgot")
                    let alertController = UIAlertController(title: "OTP?", message: "Please input OTP", preferredStyle: .alert)
                    //let field : UITextField
                    let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
                        if let field = alertController.textFields![0] as? UITextField {
                            var help = Int(field.text!)
                            if help == randomNumber{
                                self.navigationController?.pushViewController(vc!, animated: true)
                            }else{
                                print("OTP error")
                            }
                            
                        } else {
                            // user did not fill field
                        }
                    }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
                
                alertController.addTextField { (textField) in
                    textField.placeholder = "Email"
                }
                
                alertController.addAction(confirmAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
                    
                //}
            }
        }
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
infix operator !~= { associativity left }
func !~= (a: String?, b: String?) -> Bool {
    if a == nil || b == nil {
        return false
    }
    
    return a != b
}
