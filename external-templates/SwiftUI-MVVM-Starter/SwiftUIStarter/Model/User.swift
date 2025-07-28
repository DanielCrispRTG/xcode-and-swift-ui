//
//  User.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 03/09/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import ObjectMapper


struct User : Mappable {
    var name : String = ""
    var id: String = ""
    var email : String = ""
    var profile_url : String = ""
    var imageURL = ""
    
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        name <- map["name"]
        id <- map["id"]
        email <- map["email"]
        profile_url <- map["profile_url"]
        imageURL <- map["imageURL"]
    }

    
}

