//
//  UserModel.swift
//  InstaHappy
//
//  Created by Shravan on 4/2/19.
//  Copyright © 2019 Shravan. All rights reserved.
//

import Foundation

class UserModel{
    
    var name : String!
    var email : String!
    var imageURL : String!
    var title : String!
    var userID : String!

    
    init(userID: String, dictionary: Dictionary<String, AnyObject>) {
        
        self.userID = userID
        
        if let name = dictionary["name"] as? String{
            self.name = name
        }
        if let email = dictionary["email"] as? String{
            self.email = email
        }
        if let imageURL = dictionary["imageURL"] as? String{
            self.imageURL = imageURL
        }
        if let title = dictionary["title"] as? String{
            self.title = title
        }
        if let userID = dictionary["userID"] as? String{
            self.userID = userID
        }
    }
}

