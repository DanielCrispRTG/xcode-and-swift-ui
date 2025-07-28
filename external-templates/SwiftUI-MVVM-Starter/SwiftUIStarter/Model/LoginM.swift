//
//  LoginM.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 14/11/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import ObjectMapper
import SwiftUI

struct LoginM : Mappable {
    var email = ""
    var password = ""
    var deviceToken = ""
    var deviceUUID = ""
    
    init(email : String, password : String) {
        self.email = email
        self.password = password
        deviceToken = ""
        deviceUUID = ""
    }
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        email <- map["email"]
        password <- map["password"]
        deviceToken <- map["device_token"]
        deviceUUID <- map["device_uuid"]
    }
}

struct LogoutM : Mappable {
    var deviceToken = ""
    var deviceUUID = ""
    
    init(uuid : String, token : String) {
        self.deviceUUID = uuid
        self.deviceToken = token
    }
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        deviceToken <- map["device_token"]
        deviceUUID <- map["device_uuid"]
    }
}
