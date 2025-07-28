//
//  Coffee.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 05/09/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import ObjectMapper
import Foundation

struct Feed : Identifiable {
    var id = UUID()
    var name : String!
    var title : String!
    var message : String!
    var date : Date
    var image : String!
    
    init(name : String, title : String, message : String, date : String, image : String) {
        self.name = name
        self.title = title
        self.message = message
        self.date = Date(fromAPI: date)
        self.image = image
    }
}

