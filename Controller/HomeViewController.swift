//
//  HomeViewController.swift
//  InstaHappy
//
//  Created by Shravan on 3/26/19.
//  Copyright © 2019 Shravan. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var rowDate = [String]()
    //var rowDate = ["One","Two"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowDate.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = rowDate[indexPath.row]
        
        return cell
    }
    

    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        var ref =  Database.database().reference().child("Posts")
        
        ref.observe(.childAdded) { (snapShot) in
            print(snapShot)
            let key = snapShot.key
            if let postDict = snapShot.value as? Dictionary<String, AnyObject>{
                let post = PostModel(postID: key, dictionary: postDict)
                self.rowDate.append(post.title)
                self.table.reloadData()
            }
        }

        
    }
    


}
