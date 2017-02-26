//
//  signUpViewController.swift
//  thingsApp
//
//  Created by Anand Mukut Tirkey on 25/02/17.
//  Copyright © 2017 anand. All rights reserved.
//

import UIKit

class signUpViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendOTP(_ sender: UIButton) {
        //let one : String = String(describing: name.text)
        //let two : String = String(describing: password.text)
        //let three : Int = Int(phone.text!)!
        //userNameList.append(one)
        //passwordList.append(two)
        //phoneNumberList.append(Int64(three))
        //UserDefaults.standard.set(userNameList, forKey: "username")
        //UserDefaults.standard.set(passwordList,forKey : "password")
        //UserDefaults.standard.set(phoneNumberList,forKey : "phonenumber")
        //UserDefaults.standard.synchronize()
        print("successfully added")
        //print(one,two,three)
        let random = arc4random_uniform(10000)
        let randomNumber : Int64 = Int64(random)
        let number : Int64 = Int64(phone.text!)!
        var url : NSURL
        url = NSURL(string: "http://sms.dataoxytech.com/index.php/smsapi/httpapi/?uname=sylvester007&password=forskmnit&sender=FORSKT&receiver=\(number)&route=TA&msgtype=1&sms=\(randomNumber)")!
        print(url)
        let task = URLSession.shared.dataTask(with: url as URL) {(data, response, error) in
            //print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
        }
        task.resume()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
        let alertController = UIAlertController(title: "OTP?", message: "Please input OTP", preferredStyle: .alert)
        let field : UITextField
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                var help = Int64(field.text!)
                if help == randomNumber{
                    self.present(vc!, animated: true, completion: nil)
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
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
