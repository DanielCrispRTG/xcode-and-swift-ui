//
//  WebView.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 17/12/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import SwiftUI
import WebKit

struct WebViewContent : UIViewRepresentable {
      
    let request: URLRequest
      
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
      
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
      
}
struct WebView : View {
    @State var urlString : String
    var body: some View {
        WebViewContent(request: URLRequest(url: URL(string: urlString)!))
    }
}
  
#if DEBUG
struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebViewContent(request: URLRequest(url: URL(string: "https://www.apple.com")!))
    }
}
#endif
