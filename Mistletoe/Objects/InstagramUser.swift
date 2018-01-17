//
//  InstagramUser.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 15/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit

class InstagramUser: NSObject, NSCoding {
    
    var id: String = ""
    var username: String = ""
    var fullName: String = ""
    var profilePicture: String = ""
    var bio: String = ""
    var website: String = ""
    var isBusiness: Bool = false
    
    override init() {
        super.init()
    }
    
    init(id: String, username: String, fullName: String, profilePicture: String, bio: String, website: String, isBusiness: Bool) {
        self.id = id
        self.username = username
        self.fullName = fullName
        self.profilePicture = profilePicture
        self.bio = bio
        self.website = website
        self.isBusiness = isBusiness
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! String
        let username = aDecoder.decodeObject(forKey: "username") as! String
        let fullName = aDecoder.decodeObject(forKey: "fullName") as! String
        let profilePicture = aDecoder.decodeObject(forKey: "profilePicture") as! String
        let bio = aDecoder.decodeObject(forKey: "bio") as! String
        let website = aDecoder.decodeObject(forKey: "website") as! String
        let isBusiness = aDecoder.decodeBool(forKey: "isBusiness")
        
        self.init(id: id, username: username, fullName: fullName, profilePicture: profilePicture, bio: bio, website: website, isBusiness: isBusiness)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.username, forKey: "username")
        aCoder.encode(self.fullName, forKey: "fullName")
        aCoder.encode(self.profilePicture, forKey: "profilePicture")
        aCoder.encode(self.bio, forKey: "bio")
        aCoder.encode(self.website, forKey: "website")
        aCoder.encode(self.isBusiness, forKey: "isBusiness")
    }
}
