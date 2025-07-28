//
//  HeaderView.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 19/12/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import SwiftUI
import Kingfisher

struct HeaderView : View {
    
    @State private var shareAction : Bool = false
    @State var user : User = Session.shared.user
    
    var body: some View {
        HStack {
            KFImage(URL(string: self.user.imageURL))
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(30)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text(self.user.name)
                    .font(Font.Avenir(weight: .black, size: 18))
                    .foregroundColor(Color.BMBlueBlack)
                Text(self.user.profile_url)
                    .font(Font.Avenir(weight: .heavy, size: 14))
                    .foregroundColor(Color.BMBlueBlack.opacity(0.70))
            }
            Spacer()
        }.padding(.vertical, 12)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(user : User(JSON: [
            "name" : "Walter White",
            "id" : "9949",
            "email" : "walterwhite@gmail.com",
            "imageURL": "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_800x600_walter-white.jpg",
            "profile_url": "wwhite"
        ])!)
    }
}
