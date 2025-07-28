//
//  LoginViewModel.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 16/12/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import Combine


class LoginViewModel : ObservableObject {
    @Published var loading : Bool = false
    @Published var user : [User] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    var didChange = PassthroughSubject<LoginViewModel, Never>()
    
    func login(name : String, password : String){
        loading = true
        let loginObject = LoginM(email : name, password: password)
        let user = APIClient.shared.login(loginModel: loginObject)
        Session.shared.token = "Example_Token"
        Session.shared.user = user
        AppPresenter.shared.login()
        self.loading = false
    }

}


