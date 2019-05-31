//
//  SignUpViewController.swift
//  InstaHappy
//
//  Created by Shravan on 3/26/19.
//  Copyright © 2019 Shravan. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword1: UITextField!
    
    @IBOutlet weak var txtPassword2: UITextField!

    
    
    @IBOutlet weak var lblStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func RegisterPressed(_ sender: UIButton) {
        let email = txtEmail.text!
        let password1 = txtPassword1.text!
        let password2 = txtPassword2.text!
        
        if email.isEmail == false{
            lblStatus.text = "Enter a valid e mail"
            return
        }
        
        if password1.count < 6 {
            lblStatus.text = "Enter password"
            return
        }
        
        if password1 == password2 {
            Auth.auth().createUser(withEmail: email, password: password1) { authResult, error in
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
