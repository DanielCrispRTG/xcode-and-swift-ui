//
//  Viewas.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 11/12/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import SwiftUI


struct SettingsTitle : View {
    @State var title : String
    var body: some View {
        Text(title)
            .font(Font.Avenir(weight: .heavy, size: 14))
            .foregroundColor(Color.BMBlueBlack)
    }
}

#if DEBUG
struct SettingsTitle_Previews : PreviewProvider {
    static var previews: some View {
        SettingsTitle(title: "Some Settings")
    }
}
#endif
