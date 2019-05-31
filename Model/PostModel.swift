//
//  PostModel.swift
//  InstaHappy
//
//  Created by Shravan on 4/2/19.
//  Copyright © 2019 Shravan. All rights reserved.
//

import Foundation

class PostModel{
    
    var title : String!
    var likes : Int!
    var imageURL : String!
    var ownerUID : String!
    var creationDate : Date!
    var postID : String!
    
    init(postID: String, dictionary: Dictionary<String, AnyObject>) {
        
        self.postID = postID
        
        if let title = dictionary["title"] as? String{
            self.title = title
        }
        if let ownerUID = dictionary["ownerUID"] as? String{
            self.ownerUID = ownerUID
        }
        if let imageURL = dictionary["imageURL"] as? String{
            self.imageURL = imageURL
        }
        if let creationDate = dictionary["title"] as? Double{
            self.creationDate = Date(timeIntervalSince1970: creationDate)
        }
        if let likes = dictionary["likes"] as? Int{
            self.likes = likes
        }
    }
}
