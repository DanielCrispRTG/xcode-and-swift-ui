//
//  LoginView.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 12/11/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import SwiftUI


struct LoginView: View {
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var errorMessage = ""
    @State private var loading = false
    @State private var accentColor1 : Color = Color.BMGray
    @State private var accentColor2 : Color = Color.BMGray
    @ObservedObject var viewModel : LoginViewModel = LoginViewModel()
    
    var body: some View {
        GeometryReader { geometry in
                VStack {
                    Text("Login")
                        .font(Font.Avenir(weight: .black, size: 30))
                        .frame(width: geometry.size.width - 32, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 32)
                    Text("Please sign in to continue.")
                        .font(Font.Avenir(weight: .medium, size: 16))
                        .frame(width: geometry.size.width - 32, alignment: .leading)
                    
                    TextField("Username", text: self.$name,onEditingChanged: { changed in
                        if(changed) {self.accentColor1 = Color.BMBlue}
                        else {self.accentColor1 = Color.BMGray}})
                        .frame(height: 50.0)
                        .overlay(Path(CGRect(x: 0, y: 50, width: geometry.size.width - 32, height: 0.5)).foregroundColor(self.accentColor1), alignment: .bottom)
                        .padding(16)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: self.$password, onCommit: {
                        self.accentColor2 = Color.BMGray
                    })
                        .frame(height: 50.0)
                        .overlay(Path(CGRect(x: 0, y: 50, width: geometry.size.width - 32, height: 0.5))
                            .foregroundColor(self.accentColor2), alignment: .bottom)
                        .padding(16)
                    
                    Button(action: self.login) {
                        Text("Login").foregroundColor(Color.white)
                            .font(Font.Avenir(weight: .heavy, size: 17))
                            .frame(width: geometry.size.width - 32 ,height: 50.0)
                    }.background(Color.BMBlue)
                        .cornerRadius(6)
                        .shadow(radius: 3)
                    
                    Spacer()
                }
                .lineSpacing(3)
                .textFieldStyle(PlainTextFieldStyle())
                .alert(isPresented: self.$showingAlert) {
                    Alert(title: Text(self.errorMessage))
                }.transition(.move(edge: .leading))
            }
    }
    func login() {
        if name.isEmpty {
            errorMessage = "Username is empty"
            showingAlert = true
            return
        }
        if password.isEmpty {
            errorMessage = "Password is empty"
            showingAlert = true
            return
        }
        loading = true
        viewModel.login(name: name, password: password)
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        return LoginView()
    }
}
