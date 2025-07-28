//
//  ListViewModel.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 18/12/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import Foundation
import Combine

class ListViewModel : ObservableObject {
    @Published var feeds : [Feed] = []

    var didChange = PassthroughSubject<ListViewModel, Never>()
    
    func loadFeeds(){
        feeds = APIClient.shared.feeds()
        self.didChange.send(self)
    }
}
