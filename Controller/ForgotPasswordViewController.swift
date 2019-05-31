//
//  ForgotPasswordViewController.swift
//  InstaHappy
//
//  Created by KShravan on 3/26/19.
//  Copyright © 2019 Shravan. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBAction func actionForgotPressed(_ sender: UIButton) {
        let auth = Auth.auth();
        let emailAddress = email.text;
        
        //if emailAddress!.isEmail{
            //lblStatus.isHidden = false
            //lblStatus.text = "Enter valid Email"
            //return
        //}
        
        auth.sendPasswordReset(withEmail: emailAddress!) { error in
            if error == nil{
                self.lblStatus.isHidden = false
                self.lblStatus.text = "Password reset link sent to the email address"
            }
            else{
                self.lblStatus.text = "Enter valid Email"
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
