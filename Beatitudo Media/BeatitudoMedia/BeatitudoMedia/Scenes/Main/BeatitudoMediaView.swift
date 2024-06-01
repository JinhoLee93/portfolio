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
    
    @Binding var isLightModeOn: Bool
    
    @State private var currentSection: Int           = 0
    @State private var offsetX: CGFloat              = 0
    @State private var destinationURL: String        = ""
    @State private var isUserSignedIn: Bool          = GlobalAssets.isUserSignedIn
    @State private var initialLoad: Bool             = true
    @State private var presentingDestination: Bool   = false
    @State private var presentingReportSheet: Bool   = false
    @State private var showSigningSheet: Bool        = false
    @State private var showStatusPage: Bool          = false
    @State private var showSplashView: Bool          = false
    @State private var showSplashDate: Bool          = false
    @State private var showProgressView: Bool        = false
    @State private var showUserProfilePage: Bool     = false
    @State private var showViewedArticlesPage: Bool  = false
    @State private var showLovedArticlesPage: Bool   = false

    @Namespace var namespace
    
    var body: some View {
        ZStack {
            Color.adaptiveBackground
                .ignoresSafeArea()
            
            if showUserProfilePage {
                UserProfileView(showUserProfileView: $showUserProfilePage)
                    .offset(x: offsetX)
                    .transition(.move(edge: .leading))
                    .zIndex(1)
            }
            
            if showViewedArticlesPage {
                UserArticlesView(isForViewedArticle: true,
                                 showViewedArticlesPage: $showViewedArticlesPage,
                                 showLovedArticlesPage: $showLovedArticlesPage)
                    .offset(x: offsetX)
                    .transition(.move(edge: .leading))
                    .zIndex(1)
            }
            
            if showLovedArticlesPage {
                UserArticlesView(isForViewedArticle: false,
                                 showViewedArticlesPage: $showViewedArticlesPage,
                                 showLovedArticlesPage: $showLovedArticlesPage)
                    .offset(x: offsetX)
                    .transition(.move(edge: .leading))
                    .zIndex(1)
            }
            
            BeatitudoMediaProgressView()
                .opacity(showProgressView ? 1 : 0)
                .zIndex(1)
                .ignoresSafeArea()
                        
            BeatitudoMediaSplashView(showSplashDate: $showSplashDate)
                .opacity(showSplashView ? 1 : 0)
                .zIndex(1)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                    .frame(height: 50)
                
                BeatitudoMediaStatusView(isUserSignedIn: $isUserSignedIn, 
                                         showStatusPage: $showStatusPage,
                                         showSigningSheet: $showSigningSheet,
                                         showUserProfilePage: $showUserProfilePage,
                                         showViewedArticlesPage: $showViewedArticlesPage,
                                         showLovedArticlesPage: $showLovedArticlesPage)
                    .scaleEffect(CGSize(width: showStatusPage ? 1.0 : 0.98,
                                        height: showStatusPage ? 1.0 : 0.98))
            }
            .ignoresSafeArea(edges: .top)
            
            ZStack {
                Color.adaptiveBackground
                    .shadow(radius: 10)
                
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 50)
                    
                    BeatitudoMediaStatusBar(showStatusPage: $showStatusPage, isLightModeOn: $isLightModeOn)
                    
                    SectionBar(currentSectionIndex: $currentSection, namespace: namespace.self)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    
                    Divider()
                        .background(.adaptiveView)
                    
                    SectionView(currentSection: $currentSection,
                                presentingDestination: $presentingDestination,
                                destinationURL: $destinationURL,
                                presentingReportSheet: $presentingReportSheet, isUserSignedIn: $isUserSignedIn,
                                showSigningSheet: $showSigningSheet)
                    
                }
                .opacity(viewModel.sections.isEmpty ? 0 : 1)
                
//                ReportSheetView(presentingReportSheet: $presentingReportSheet)
            }
            .environmentObject(viewModel)
//            .analyticsScreen(name: "\(BeatitudoMediaView.self)")
            .navigationDestination(isPresented: $presentingDestination, destination: {
                NavigationStack {
                    WebView(url: destinationURL)
                        .navigationTitle(Text(viewModel.tokenizeURLandReturnName(destinationURL)))
                        .ignoresSafeArea(edges: .bottom)
                }
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
            if initialLoad {
                do {
                    initialLoad = false
                    showSplashView = true
                    
                    if GlobalAssets.isUserSignedIn {
                        try await viewModel.fetchCurrentUser()
                    }
                    
                    try await viewModel.refreshSections()
                    
                    withAnimation(.easeInOut(duration: 0.25)) {
                        showSplashDate = true
                    }
                    
                    try await Task.sleep(for: .seconds(1))
                    
                    withAnimation(.easeInOut(duration: 0.25)) {
                        showSplashView = false
                    }
                    
                    print("Current User: \(String(describing: GlobalAssets.currentUser))")
                } catch {
                    print("\(error) occurred fetching sections.")
                    showSplashView = false
                }
            }
        }
        .onChange(of: isUserSignedIn) { _, _ in
            Task {
                showProgressView = true
                try await viewModel.refreshSections()
                showProgressView = false
            }
        }
    }
}

#Preview {
    BeatitudoMediaView(isLightModeOn: .constant(true))
}

