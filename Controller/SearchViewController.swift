//
//  SearchViewController.swift
//  InstaHappy
//
//  Created by Shravan on 3/26/19.
//  Copyright © 2019 Shravan. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listUserNames = [UserModel]()
    var list = ["one","two"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUserNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("SearchTableViewCell", owner: self, options: nil)?.first as! SearchTableViewCell
        cell.lblName?.text = listUserNames[indexPath.row].name
        
        
        return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var ref =  Database.database().reference().child("Users")
        
        ref.observe(.childAdded) { (snapShot) in
            print(snapShot)
            let key = snapShot.key
            if let postDict = snapShot.value as? Dictionary<String, AnyObject>{
                let user1 = UserModel(userID: key, dictionary: postDict)
                self.listUserNames.append(user1)
                self.table.reloadData()
            }
        }

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var table: UITableView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
