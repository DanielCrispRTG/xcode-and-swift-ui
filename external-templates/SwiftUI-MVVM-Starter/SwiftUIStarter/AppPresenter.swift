//
//  AppPresenter.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 18/11/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import SwiftUI

class AppPresenter {
    var scene : SceneDelegate!
    var window : UIWindow!
    var app : AppDelegate!
    
    static func initialize(app : AppDelegate) {
        shared = AppPresenter(app: app)
        
    }
    
    private init(app : AppDelegate) {
        self.app = app
       
    }
    private init(scene : SceneDelegate) {
        self.scene = scene
        self.window = scene.window
    }
    private init(){}
    
    static var shared = AppPresenter()
    
    func initializeWithScene(scene : SceneDelegate) {
        self.scene = scene
        self.window = scene.window
    }
    
    var vc : HostingController? {
        return window.rootViewController as? HostingController
    }
    
    func start(window : UIWindow) {
        if Session.shared.isLogged {
            let contentView = ContentView()
            let controller = HostingController(rootView : contentView)
            controller.view.backgroundColor = Color.BMBlue.uiColor
            window.rootViewController = controller
           
        }
        else {
            let contentView = LoginView()
            window.rootViewController = UIHostingController(rootView : contentView)
        }
        self.window = window
    }
    
    func login(){
        let contentView = ContentView()
        let controller = HostingController(rootView : contentView)
        controller.view.backgroundColor = Color.BMBlue.uiColor
        window.rootViewController = controller
        animateWindow()
        
    }
    
    func openLogin() {
        let contentView = LoginView()
        window.rootViewController = UIHostingController(rootView : contentView)
        animateWindow()
    }
    
    func logout(){
        APIClient.shared.logout()
        Session.shared.logout()
        openLogin()
    }

    
    func animateWindow() {
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        
        // The duration of the transition animation, measured in seconds.
        let duration: TimeInterval = 0.3
        
        // Creates a transition animation.
        // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
            { completed in
                // maybe do something on completion here
        })
    }

}
