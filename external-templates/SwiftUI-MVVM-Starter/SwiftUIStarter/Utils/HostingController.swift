//
//  HostingController.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 18/12/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import SwiftUI
import UIKit

class HostingController : UIHostingController<ContentView> {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
