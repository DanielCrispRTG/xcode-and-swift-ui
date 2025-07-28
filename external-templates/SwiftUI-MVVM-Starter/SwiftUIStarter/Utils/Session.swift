//
//  Session.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 13/11/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import UIKit

class Session : ObservableObject {
    static let shared = Session()
    private let defaults = UserDefaults.standard

    func login(token : String) {
        self.token = token
        self.isLogged = true
    }
    func login() {
        self.isLogged = true
    }
    
    
    func logout() {
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
    }
    
    func userToken() -> String? {
        return defaults.string(forKey: Constants.Key.USER_TOKEN)
    }
    
    var user : User {
        set {
            defaults.set(newValue.toJSON(), forKey: Constants.Key.USER_DATA)
            defaults.synchronize()
        }
        get {
            return DummyData.user
        }
    }
    
    var token : String? {
        set {
            defaults.set(newValue,forKey: Constants.Key.USER_TOKEN)
            defaults.synchronize()
            isLogged = true
        }
        get {
            return defaults.string(forKey: Constants.Key.USER_TOKEN)
        }
    }
    
    var isLogged : Bool {
        set {
            defaults.set(newValue,forKey: Constants.Key.IS_LOGGED)
        }
        get {
            return defaults.bool(forKey: Constants.Key.IS_LOGGED)
        }
    }
    var notificationStatus : Bool {
        set {
            defaults.set(newValue, forKey: Constants.Key.NOTIFICATION_STATUS)
        }
        get {
            defaults.bool(forKey: Constants.Key.NOTIFICATION_STATUS)
        }
    }
    
    var vendorID: String {
          return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
}

