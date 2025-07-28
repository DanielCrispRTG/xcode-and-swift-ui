//
//  CoffeeContent.swift
//  SwiftUIBMC
//
//  Created by Shakeeb M on 19/11/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import SwiftUI
import Combine
import struct Kingfisher.KFImage

struct FeedContent: View {
    @State var feed : Feed
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                KFImage(URL(string: feed.image))
                    .resizable()
                    .frame(width:47,height: 47)
                    .cornerRadius(47/2)
                VStack(alignment: .leading) {
                    Text(feed.name).font(Font.Avenir(weight: .heavy, size: 15)) + Text(" bought you a \(feed.title)").font(Font.Avenir(weight: .book, size: 15))
                    if !feed.message.isEmpty {
                        Text(feed.date.getElapsedInterval())
                            .font(.custom("Avenir", size: 11))
                            .fontWeight(.medium)
                            .foregroundColor(Color.gray)
                    }
                }
                Spacer()
            }
            if !feed.message.isEmpty {
                HStack {
                    ZStack() {
                        Text(feed.message)
                            .font(Font.Avenir(weight: .book, size: 15))
                            .padding(12)
                    }.background(RoundedCorners(tl: 0, tr: 8, bl: 8, br: 8)
                        .fill(Color.BMConversationGray))
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                    Spacer()
                }
                Text(feed.date)
                    .font(.custom("Avenir", size: 11))
                    .fontWeight(.medium)
                    .foregroundColor(Color.BMLightGray)
                    .padding(.leading, 18)
                    .padding(.top, 2)
            }
            
        }.padding(12)
            .background(ShadowView())
    }
    func writeReply(){
        
    }

}



struct CoffeeContent_Previews: PreviewProvider {
    static var previews: some View {
        let coffee = Feed(name: "Shiela10",
                          title: "Thanks 😊",
                          message: "Hi There",
                          date: "2019-11-16 08:50:08",
                          image: "https://images.unsplash.com/photo-1554411529-ee36dfde51b9?ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80"
        return FeedContent(feed: Feed(coffee: coffee))
    }
}
