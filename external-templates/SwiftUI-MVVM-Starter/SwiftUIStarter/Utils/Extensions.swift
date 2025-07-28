//
//  Extensions.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 14/11/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import Foundation

extension Date {
    init(fromAPI : String) {
        let dateFormat = "yyyy-M-dd HH:mm:ss"
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.dateFormat = dateFormat
        self = df.date(from: fromAPI) ?? Date()
    }
    
    func getElapsedInterval() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day,.hour,.minute], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            if(day >= 7){
                let week = day / 7
                return week == 1 ? "\(week)" + " " + "week ago" :
                 "\(week)" + " " + "weeks ago"
            }
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour ago" :
                    "\(hour)" + " " + "hours ago"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute ago" :
                "\(minute)" + " " + "minutes ago"
        }
        else {
            return "a minute ago"
        }
    }
}

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

