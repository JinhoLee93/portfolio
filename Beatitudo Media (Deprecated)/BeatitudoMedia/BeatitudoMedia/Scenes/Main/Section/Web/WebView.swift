//
//  WebView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/4/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let uiView = WKWebView()
        let request = URLRequest(url: URL(string: url)!)
        uiView.load(request)
        
        return uiView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: URL(string: url)!)
        uiView.load(request)
    }
}
