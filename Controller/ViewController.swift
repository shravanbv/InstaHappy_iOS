//
//  ViewController.swift
//  InstaHappy
//
//  Created by Shravan on 3/19/19.
//  Copyright © 2019 Shravan. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBOutlet weak var lblStatus: UILabel!
    
    
    @IBAction func LoginButtonPressed(_ sender: UIButton) {
        let email = txtEmail.text!
        let password = txtPassword.text!
        
        if email.isEmail == false{
            lblStatus.isHidden = false
            lblStatus.text = "Enter a valid e mail"
            return
        }
        if password.count < 6 {
            lblStatus.isHidden = false
            lblStatus.text = "Enter password"
            return
        }
    
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else { return }
            
            SVProgressHUD.dismiss()
            if error == nil{
                strongSelf.lblStatus.isHidden = false
                // perform segue
                strongSelf.AddKeyChainAfterLogin(uid: user!.user.uid)
                strongSelf.performSegue(withIdentifier: "LoginSegue", sender: strongSelf)
            }
            else{
                strongSelf.lblStatus.text = error?.localizedDescription
                return
            }
        }
}
    
    @IBAction func Forgotpassword(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ForgotPassword", sender: self)
    }
    
    @IBAction func SignupPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "SignUpSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //lblStatus.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        let keyChain = KeyChainService().keyChain
        if keyChain.get("uid") != nil {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    
    func AddKeyChainAfterLogin(uid: String){
        let keyChain = KeyChainService().keyChain
        keyChain.set(uid, forKey: "uid")
    }

}

