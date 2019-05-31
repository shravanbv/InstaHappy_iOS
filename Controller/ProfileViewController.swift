//
//  ProfileViewController.swift
//  InstaHappy
//
//  Created by Shravan on 3/26/19.
//  Copyright © 2019 Shravan. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ProfileViewController: UIViewController {

    @IBOutlet weak var ProfilePicture: UIImageView!
    
    
    @IBOutlet weak var txtFullName: UITextField!
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBAction func FullNameChanged(_ sender: Any) {
        
        guard let user = Auth.auth().currentUser else { return }
        let changeRequest = user.createProfileChangeRequest()
        
        changeRequest.displayName = txtFullName.text
        
        changeRequest.commitChanges { error in
            if error != nil{
                print(error.debugDescription)
                return
            }
            print("Profile Update")
            
        }
    }
    
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBAction func UploadPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadUserProfile()

        // Do any additional setup after loading the view.
    }
    
    
    
    func LoadUserProfile(){
        
        guard let user = Auth.auth().currentUser else { return }
        
        if let name = user.displayName{
            txtFullName.text = name
        }
        
        if let email = user.email{
            txtEmail.text = email
        }
        
        if let photoURL = user.photoURL{
            //
        }
    }
    
    
    
    
    
    @IBAction func SignOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try
                firebaseAuth.signOut()
            KeyChainService().keyChain.delete("uid")
            self.navigationController?.popViewController(animated: true)
            print ("signing out...")
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            return
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
