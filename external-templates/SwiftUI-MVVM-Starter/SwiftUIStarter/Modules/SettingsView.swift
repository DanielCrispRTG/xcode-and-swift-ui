//
//  SettingsView.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 30/11/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import SwiftUI


struct SettingsView: View {
    
    @ObservedObject var viewModel = SettingsViewModel()
    
    init() {
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        List {
            HeaderView(user : Session.shared.user)
            Toggle(isOn: $viewModel.notificationStatus) {
                SettingsTitle(title: "Notification")
            }.onTapGesture(perform: viewModel.setNotification)
            //Put actual URL
            NavigationLink(destination:
                WebView(urlString:  "https://www.google.com")
                    .navigationBarTitle("",displayMode: .inline)
            ) {
                SettingsTitle(title: "Help Center")
            }
            NavigationLink(destination: AboutUsView()) {
                SettingsTitle(title: "About us")
            }
            
            Button(action: viewModel.logout){
                HStack(alignment: .center) {
                    SettingsTitle(title : "Logout")
                    Spacer()
                    Image("icListIndicator")
                }
            }
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
