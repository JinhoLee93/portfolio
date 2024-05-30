//
//  UserArticlesView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/28/24.
//

import SwiftUI

struct UserArticlesView: View {
    @StateObject private var viewModel = UserArticlesViewModel()
    
    let isForViewedArticle: Bool
    
    @Binding var showViewedArticlesPage : Bool
    @Binding var showLovedArticlesPage  : Bool
    
    @State private var presentingDestination: Bool          = false
    @State private var presentingReportSheet: Bool          = false
    @State private var destinationURL: String               = ""
    @State private var selectedSortingMethod: SortingMethod = .countOfLoved
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.adaptiveBackground
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 50)
                
                HStack {
                    ZStack {
                        HStack {
                            Button {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    showViewedArticlesPage = false
                                    showLovedArticlesPage = false
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.adaptiveView)
                            }
                            
                            Spacer()
                        }
                        .padding(.leading, 20)
                        
                        Text(isForViewedArticle ? "읽은 기사" : "좋아한 기사")
                            .foregroundStyle(.adaptiveText)
                    }
                }
                .frame(height: 48)
                
                HStack {
                    Menu {
                        Picker("Sort by", selection: $selectedSortingMethod) {
                            Text("좋아요 많은 순").tag(SortingMethod.countOfLoved)
                            Text("최신 순").tag(SortingMethod.latest)
                            Text("오래된 순").tag(SortingMethod.oldest)
                            Text("뷰 많은 순").tag(SortingMethod.countOfViews)
                        }
                    } label: {
                        HStack(spacing: 0) {
                            Text("Sort by: ")
                            
                            if selectedSortingMethod == .countOfLoved {
                                Text("좋아요 많은 순")
                            } else if selectedSortingMethod == .latest {
                                Text("최신 순")
                            } else if selectedSortingMethod == .oldest {
                                Text("오래된 순")
                            } else {
                                Text("뷰 많은 순")
                            }
                        }
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                }
                .padding(.leading, 20)
                .frame(height: 32)
                
                Divider()
                    .background(.adaptiveView)
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(viewModel.articles ?? [], id: \.self) { article in
                            ArticleView(article: article,
                                        presentingDestination: $presentingDestination,
                                        destinationURL: $destinationURL,
                                        presentingReportSheet: $presentingReportSheet,
                                        isUserSignedIn: .constant(true),
                                        showSigningSheet: .constant(false))
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .ignoresSafeArea()
        .task {
            do {
                try await viewModel.translateUserArticlesIntoArticles(isForViewedArticles: isForViewedArticle)
            } catch {
                print("\(error) occurrred translating user articles to Articles")
            }
        }
        .navigationDestination(isPresented: $presentingDestination, destination: {
            NavigationStack {
                WebView(url: destinationURL)
            }
        })
        .onChange(of: selectedSortingMethod) { _, newValue in
            viewModel.sortArticlesBy(method: newValue)
        }
    }
}

// MARK: - Picker
enum SortingMethod: String, CaseIterable, Identifiable {
    case latest, oldest, countOfViews, countOfLoved
    var id: Self { self }
}
