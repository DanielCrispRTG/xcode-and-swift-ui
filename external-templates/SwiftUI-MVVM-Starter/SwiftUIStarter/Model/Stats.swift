//
//  Stats.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 07/09/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import ObjectMapper

struct Stats : Mappable {
    var allTimeReactions : Float = 0
    var posts = 0
    var todayReactions : Float = 0
    var todayViews = 0
    var monthReactions : Float = 0
    var monthViews = 0
    var weekReactions : Float = 0
    var weekViews = 0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        allTimeReactions <- map["all_time_reactions"]
        posts <- map["posts"]
        todayReactions <- map["today_reactions"]
        todayViews <- map["today_views"]
        monthReactions <- map["month_reactions"]
        monthViews <- map["month_views"]
        weekReactions <- map["week_reactions"]
        weekViews <- map["week_views"]
    }
}
