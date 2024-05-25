//
//  BeatitudoMediaView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/1/24.
//

import SwiftUI
import Firebase

struct BeatitudoMediaView: View {
    @StateObject private var viewModel: BeatitudoMediaViewModel = BeatitudoMediaViewModel()
    
    @State private var isUserSignedIn: Bool        = GlobalAssets.isUserSignedIn
    @State private var currentSection: Int         = 0
    @State private var presentingDestination: Bool = false
    @State private var presentingReportSheet: Bool = false
    @State private var showSigningSheet: Bool        = false
    @State private var showStatusPage: Bool        = false
    @State private var destinationURL: String      = ""
    @State private var offsetX: CGFloat            = 0
    @State private var showSplashView: Bool        = false
    @State private var showSplashDate: Bool        = false

    @Namespace var namespace
    
    var body: some View {
        ZStack {
            Color.adaptiveBackground
                .ignoresSafeArea()
                        
            BeatitudoMediaSplashView(showSplashDate: $showSplashDate)
                .opacity(showSplashView ? 1 : 0)
                .zIndex(1)
                .ignoresSafeArea()
            
            VStack {
                Spacer(minLength: 45)
                
                BeatitudoMediaStatusView(isUserSignedIn: $isUserSignedIn, showStatusPage: $showStatusPage, showSigningSheet: $showSigningSheet)
                    .scaleEffect(CGSize(width: showStatusPage ? 1.0 : 0.98,
                                        height: showStatusPage ? 1.0 : 0.98))
            }
            .ignoresSafeArea(edges: .top)
            
            ZStack {
                Color.adaptiveBackground
                    .shadow(radius: 10)
                
                VStack(spacing: 0) {
                    Spacer(minLength: 45)
                    
                    BeatitudoMediaStatusBar(showStatusPage: $showStatusPage)
                    
                    SectionBar(currentSectionIndex: $currentSection, namespace: namespace.self)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    
                    Divider()
                        .background(.adaptiveView)
                    
                    SectionView(currentSection: $currentSection,
                                presentingDestination: $presentingDestination,
                                destinationURL: $destinationURL,
                                presentingReportSheet: $presentingReportSheet, isUserSignedIn: $isUserSignedIn, showSigningSheet: $showSigningSheet)
                }
                .opacity(viewModel.sections.isEmpty ? 0 : 1)
                
//                ReportSheetView(presentingReportSheet: $presentingReportSheet)
            }
            .environmentObject(viewModel)
//            .analyticsScreen(name: "\(BeatitudoMediaView.self)")
            .navigationDestination(isPresented: $presentingDestination, destination: {
                NavigationStack {
                    WebView(url: destinationURL)
                }
                .navigationTitle(Text(viewModel.tokenizeURLandReturnName(destinationURL)))
                .navigationBarTitleDisplayMode(.inline)
            })
            .offset(x: offsetX)
            .ignoresSafeArea(edges: [.top, .bottom])
            .disabled(showStatusPage)
            .onTapGesture {
                if showStatusPage {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        showStatusPage = false
                    }
                }
            }
            .onChange(of: showStatusPage) { _, newValue in
                withAnimation(.easeInOut(duration: 0.25)) {
                    offsetX = newValue ? -270 : 0
                }
            }
            
            BeatitudoMediaSigningView(showSigningSheet: $showSigningSheet, isUserSignedIn: $isUserSignedIn)
        }
        .task {
            do {
                showSplashView = true
                
                try await viewModel.refreshSections()
                
                withAnimation(.easeInOut(duration: 0.25)) {
                    showSplashDate = true
                }
                
                try await Task.sleep(for: .seconds(1))
                
                withAnimation(.easeInOut(duration: 0.25)) {
                    showSplashView = false
                }
            } catch {
                print("\(error) occurred fetching/refreshing sections.")
                showSplashView = false
            }
        }
    }
}

#Preview {
    BeatitudoMediaView()
}

