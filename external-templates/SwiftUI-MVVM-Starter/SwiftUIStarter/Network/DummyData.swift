//
//  DummyData.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 14/05/20.
//  Copyright © 2020 Shakeeb M. All rights reserved.
//

import Foundation

struct DummyData {
    static let user : User = User(JSON: [
        "name": "Walter White",
        "id": "10999",
        "email": "walterwhite@gmail.com",
        "profile_url": "wwhite",
        "imageURL" : "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_800x600_walter-white.jpg"
    ])!
    static let feeds : [Feed] = [
        Feed(name: "Jesse Pinkman", title: "Tread Lightly", message: "If you don’t know who I am, then maybe your best course would be to tread lightly.", date: "2020-5-20 08:50:08", image: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_800x600_jesse-pinkman.jpg"),
        Feed(name: "Heisenberg", title: "I Am The One Who Knocks", message: "You clearly don’t know who you’re talking to, so let me clue you in. I am not in danger, Skyler. I am the danger. A guy opens his door and gets shot, and you think that of me? No! I am the one who knocks!", date: "2020-3-20 12:00:00", image: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_800x600_walter-white.jpg"),
        Feed(name: "Walter White", title: "Accepting Fear", message: "I have spent my whole life scared, frightened of things that could happen, might happen, might not happen, 50 years I spent like that. Finding myself awake at three in the morning. But you know what? Ever since my diagnosis, I sleep just fine. What I came to realize is that fear, that’s the worst of it. That’s the real enemy. So, get up, get out in the real world and you kick that bastard as hard you can right in the teeth.", date: "2020-1-16 08:00:00", image: "https://images.unsplash.com/photo-1554411529-ee36dfde51b9?ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80"),
        Feed(name: "Jesse Pinkman", title: "Criminal Lawyer", message: "You Don’t Need A Criminal Lawyer. You Need A 'Criminal' Lawyer.", date: "2020-1-15 08:50:08", image: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_800x600_jesse-pinkman.jpg"),
        Feed(name: "Jesse ", title: "Criminal Lawyer", message: "You Don’t", date: "2020-1-15 08:50:08", image: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_800x600_jesse-pinkman.jpg"),

        Feed(name: "Hank Schrader", title: "Now look", message: "Now look buddy, the last thing I want to do is get you in hot water, but some meth monkey had a feeding frenzy in here.", date: "2019-11-16 08:50:08", image: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_hank-schrader-lg.jpg")
    ]
    static let stats = Stats(JSON: ["all_time_reactions" : 43,
                                    "posts" : 291,
                                    "today_reactions" : 32,
                                    "today_views" : 103,
                                    "week_reactions" : 232,
                                    "week_views" : 1031,
                                    "month_reactions" : 543,
                                    "month_views" : 3032])!
}
