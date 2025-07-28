//
//  ContentView.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 12/11/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selectTab = 1
    
    var body: some View {
        TabView(selection: $selectTab) {
            NavigationView {
            HomeView()
                .navigationBarTitle("SwiftUI Starter")
            }.tabItem {
                VStack {
                    Image("tabHome")
                    Text("Home")
                    }
            }.tag(1)
            NavigationView {
            StatsView()
                .navigationBarTitle("Dashboard")
            }.tabItem {
                VStack {
                    Image("tabStats")
                    Text("Stats")
                    }
            }.tag(2)
            NavigationView {
                SettingsView()
                    .navigationBarTitle("Settings")
            }
             .tabItem{
                VStack {
                    Image("tabSettings")
                    Text("Settings")
                    }
            }.tag(4)
        }
        .accentColor(Color.BMBlack)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



