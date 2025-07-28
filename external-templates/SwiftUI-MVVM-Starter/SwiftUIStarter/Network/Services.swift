//
//  Services.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 13/11/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import Foundation

class APIClient {
    static let shared = APIClient()

    func login(loginModel : LoginM) -> User {return DummyData.user}
    func logout() -> Void {return}
    func feeds() -> [Feed] {return DummyData.feeds}
    func stats() -> Stats {return DummyData.stats}
    func getNotificationStatus() -> NotificationStatus {return NotificationStatus(isOn: false)}
    func setNotificationStatus(notification : NotificationStatus) -> NotificationStatus {return notification}
}
