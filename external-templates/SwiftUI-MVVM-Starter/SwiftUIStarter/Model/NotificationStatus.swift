//
//  NotificationStatus.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 11/12/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import ObjectMapper

struct NotificationStatus : Mappable {
    var enabled : Bool!
    
    init(isOn : Bool) {
        self.enabled = isOn
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        enabled <- map["notification_status"]
    }
}
