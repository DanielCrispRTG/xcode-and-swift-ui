//
//  HomeView.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 22/11/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import SwiftUI
import Combine

struct HomeView: View {
    @ObservedObject var viewModel = ListViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.feeds, id: \.id) { feed in
                FeedContent(feed: feed)
            }
        }.onAppear {
            self.viewModel.loadFeeds()
        }
    }
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
}

#if DEBUG
struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif
