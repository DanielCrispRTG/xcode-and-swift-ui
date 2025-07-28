//
//  StatsView.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 25/11/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import SwiftUI
import Combine

struct StatsView: View {
    @ObservedObject var viewModel : StatViewModel = StatViewModel()

    
    var body: some View {
        VStack {
            List {
                HStack {
                    Spacer().frame(width: 36.0)
                    VStack(alignment: .leading) {
                        Text("\(viewModel.stat?.allTimeReactions.clean ?? "0")M")
                            .font(.custom("Avenir", size: 35))
                            .fontWeight(.black)
                            .foregroundColor(Color.BMBlueBlack)
                        Text("Total Reactions")
                            .font(.custom("Avenir", size: 15))
                            .fontWeight(.medium)
                            .foregroundColor(Color.BMBlueBlack)
                    }
                    Spacer().frame(width: 36.0)
                    VStack(alignment: .leading) {
                        Text("\(viewModel.stat?.posts ?? 0)")
                            .font(.custom("Avenir", size: 35))
                            .fontWeight(.black)
                            .foregroundColor(Color.BMBlueBlack)
                        Text("Posts")
                            .font(.custom("Avenir", size: 15))
                            .fontWeight(.medium)
                            .foregroundColor(Color.BMBlueBlack)
                    }
                    Spacer()
                }.frame(height: 170.0)
                   
                VStack(alignment: .leading) {
                    Text("Today").font(.custom("Avenir", size: 15)).fontWeight(.heavy).autocapitalization(.allCharacters)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(viewModel.stat?.todayReactions.clean ?? "0")")
                                .font(.custom("Avenir", size: 20))
                                .fontWeight(.black)
                                .foregroundColor(Color.BMBlueBlack)
                            Text("Reactions")
                                .font(.custom("Avenir", size: 15))
                                .fontWeight(.light)
                        }
                        Spacer()
                            .frame(width: 36.0)
                        VStack(alignment: .leading) {
                            Text("\(viewModel.stat?.todayViews ?? 0)")
                                .font(.custom("Avenir", size: 20))
                                .fontWeight(.black)
                                .foregroundColor(Color.BMBlueBlack)
                            Text("Views")
                                .font(.custom("Avenir", size: 15))
                                .fontWeight(.light)
                        }
                        Spacer()
                    }.padding(.leading, 16)
                        .padding(.top, 8)
                }
                .padding(12.0)
                .cornerRadius(12.0)
                .border(Color.BMGray,width: 1)
                
                VStack(alignment: .leading) {
                    Text("Last 7 days").font(.custom("Avenir", size: 15)).fontWeight(.heavy).autocapitalization(.allCharacters)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(viewModel.stat?.weekReactions.clean ?? "0")")
                                .font(.custom("Avenir", size: 20))
                                .fontWeight(.black)
                                .foregroundColor(Color.BMBlueBlack)
                            Text("Reactions")
                                .font(.custom("Avenir", size: 15))
                                .fontWeight(.light)
                        }
                        Spacer()
                            .frame(width: 36.0)
                        VStack(alignment: .leading) {
                            Text("\(viewModel.stat?.weekViews ?? 0)")
                                .font(.custom("Avenir", size: 20))
                                .fontWeight(.black)
                                .foregroundColor(Color.BMBlueBlack)
                            Text("Views")
                                .font(.custom("Avenir", size: 15))
                                .fontWeight(.light)
                        }
                        Spacer()
                    }.padding(.leading, 16)
                        .padding(.top, 8)
                }
                .padding(12.0)
                .cornerRadius(12.0)
                .border(Color.BMGray, width: 1)
                
                VStack(alignment: .leading) {
                    Text("Last 30 days").font(.custom("Avenir", size: 15)).fontWeight(.heavy).autocapitalization(.allCharacters)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(viewModel.stat?.monthReactions.clean ?? "0")")
                                .font(.custom("Avenir", size: 20))
                                .fontWeight(.black)
                                .foregroundColor(Color.BMBlueBlack)
                            Text("Reactions")
                                .font(.custom("Avenir", size: 15))
                                .fontWeight(.light)
                        }
                        Spacer()
                            .frame(width: 36.0)
                        VStack(alignment: .leading) {
                            Text("\(viewModel.stat?.monthViews ?? 0)")
                                .font(.custom("Avenir", size: 20))
                                .fontWeight(.black)
                                .foregroundColor(Color.BMBlueBlack)
                            Text("Views")
                                .font(.custom("Avenir", size: 15))
                                .fontWeight(.light)
                        }
                        Spacer()
                    }.padding(.leading, 16)
                        .padding(.top, 8)
                }
                .padding(12.0)
                .cornerRadius(12.0)
                .border(Color.BMGray, width: 1)
            }
        }.onAppear(perform: viewModel.loadStats)
    }
    
}

class StatViewModel : ObservableObject {
    @Published var stat : Stats?
    
    func loadStats() {
        stat = APIClient.shared.stats()
        
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        return StatsView()
    }
}
