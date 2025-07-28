//
//  SettingsViewModel.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 17/12/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import Foundation

class SettingsViewModel : ObservableObject {
    var notificationStatus : Bool = Session.shared.notificationStatus
    
    func loadNotifications(){
        let notification = APIClient.shared.getNotificationStatus()
        self.notificationStatus = notification.enabled
    }
    
    func setNotification() {
        let notification = APIClient.shared.setNotificationStatus(notification: NotificationStatus(isOn: !notificationStatus))
        Session.shared.notificationStatus = notification.enabled
    }

    func logout() {
        AppPresenter.shared.logout()
    }
}

