//
//  loginViewController.swift
//  thingsApp
//
//  Created by Anand Mukut Tirkey on 25/02/17.
//  Copyright © 2017 anand. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        //DispatchQueue.main.async(execute: {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
            //self.navigationController?.pushViewController(vc!, animated: true)
            present(vc!, animated: true, completion: nil)
        //})
    }

    @IBAction func signUpAction(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "signup")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
     @IBAction func forgotAction(_ sender: UIButton) {
        /*DispatchQueue.main.async(execute: {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "forgot")
            self.present(vc!, animated: true, completion: nil)
        })*/
        let vc = storyboard?.instantiateViewController(withIdentifier: "forgot")
        self.navigationController?.pushViewController(vc!, animated: true)
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
