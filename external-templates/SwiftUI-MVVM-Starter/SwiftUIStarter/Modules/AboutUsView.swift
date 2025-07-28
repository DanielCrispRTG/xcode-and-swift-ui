//
//  AboutUsView.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 22/05/20.
//  Copyright © 2020 Shakeeb M. All rights reserved.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        VStack(alignment: .leading) {
                Text("About app")
                    .font(Font.Avenir(weight: .heavy, size: 16))
                    .padding(.bottom, 8)
                Text("SwiftUIStarter is a demo app for beginers. which built in MVVM architecture and SwiftUI. App starts with login then into a TabView design. also it demonstrate a usage of List,NavigationView,WebView and WebService Calls")
                    .fontWeight(.light)
                    .font(Font.Avenir(weight: .light, size: 16))
                    .frame(alignment: .leading)
                Spacer()
            }
             .padding(12)
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
