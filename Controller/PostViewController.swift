//
//  PostViewController.swift
//  InstaHappy
//
//  Created by Shravan on 3/26/19.
//  Copyright © 2019 Shravan. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var txtPost: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var lblStatus: UILabel!
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    
    }
    
    @IBAction func UploadImagePressed(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Please Select Source", message: "Photo Sourse", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else{
                print("Camera not available")
            }
        }))
        
        actionSheet.addAction( UIAlertAction(title: "Photo Library", style: .default, handler: { (UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction( UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func SharePostPressed(_ sender: UIButton) {
        
        guard let image = imageView.image else {
            self.lblStatus.text = "Please uplaod an image"
            return
            
        }
        
        guard
            let title = txtPost.text,
            let data = image.pngData(),
            let userID = Auth.auth().currentUser?.uid
            else {return}
        
        let creationData = Int(NSDate().timeIntervalSince1970)
        
        var fileName = NSUUID().uuidString
        fileName.append(".png")
        
        SVProgressHUD.show()
        Storage.storage().reference().child("post_images").child(fileName).putData(data, metadata: nil)
        { (metaFromStorage, error) in
            
            SVProgressHUD.dismiss()
            if error != nil{
                print("Error occured in uplaoding file")
                print(error.debugDescription)
                //self..lbl_post
                return;
                
            }
            print(metaFromStorage)
            
            
            guard let imageURL = metaFromStorage?.path else {return}
            
            let values = [ "title" : title,
                           "creationdate" : creationData,
                           "likes" : 0,
                           "imageURL" : imageURL,
                           "ownerUID" : userID
                
                         ] as [String: Any]
            
            let postID = Database.database().reference().child("Posts").childByAutoId()
            
            SVProgressHUD.show()
            postID.updateChildValues(values) { (err, ref) in
                
                SVProgressHUD.dismiss()
                if err != nil{
                    self.lblStatus.text = "Error in Updatin Database"
                    print(err.debugDescription)
                    return;
                }
                
                self.tabBarController?.selectedIndex = 0
                
            }
            
            
            
        }
        
        
    }

}
