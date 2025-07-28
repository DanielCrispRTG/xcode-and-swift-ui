//
//  CoffeeContent.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 19/11/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import SwiftUI
import Combine
import Kingfisher

struct FeedContent: View {
    @State var feed : Feed
    @State var height = 16
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                KFImage(URL(string: feed.image))
                    .resizable()
                    .frame(width:47,height: 47)
                    .cornerRadius(47/2)
                VStack(alignment: .leading) {
                    Text(feed.name).font(Font.Avenir(weight: .heavy, size: 15))
                    Text(feed.date.getElapsedInterval())
                        .font(.custom("Avenir", size: 11))
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)
                }
                Spacer()
            }
            Text("\(feed.title)").font(Font.Avenir(weight: .medium, size: 15))
            HStack {
                Rectangle()
                    .background(Color.BMBlue)
                    .frame(width: 2)
                    .frame(minHeight: 16)
                
                Text(self.feed.message)
                    .font(Font.Avenir(weight: .book, size: 15).italic())
                    .padding(.vertical,12)
                    .padding(.horizontal, 12)
                Spacer()
            }
            .frame(alignment: .leading)
            .cornerRadius(6)
            .background(Color.BMConversationGray)
            
        }.padding(12)
        
    }
    
}



struct FeedContent_Previews: PreviewProvider {
    static var previews: some View {
        let feed = Feed(name: "Shiela10",
                        title: "Thanks 😊",
                        message: "Hi There",
                        date: "2019-11-16 08:50:08",
                        image: "https://images.unsplash.com/photo-1554411529-ee36dfde51b9?ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80")
        return FeedContent(feed: feed)
    }
}
