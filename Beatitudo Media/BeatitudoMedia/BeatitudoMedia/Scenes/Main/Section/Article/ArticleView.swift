//
//  ArticleView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/2/24.
//

import SwiftUI

struct ArticleView: View {
    @StateObject private var viewModel: ArticleViewModel
    
    @Binding var presentingDestination: Bool
    @Binding var destinationURL: String
    @Binding var presentingReportSheet: Bool
    
    init(article: Article, presentingDestination: Binding<Bool>, destinationURL: Binding<String>, presentingReportSheet: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: ArticleViewModel(article: article))
        self._presentingDestination = presentingDestination
        self._destinationURL = destinationURL
        self._presentingReportSheet = presentingReportSheet
    }
    
    var body: some View {
        ZStack {
            Color.adaptiveBackground
            
            VStack(alignment: .leading, spacing: 5) {
                ArticleMetadataView(articleMetadata: ArticleMetadata(timeToRead: Int.random(in: 1...10), date: "2024-\(Int.random(in: 1...12))-\(Int.random(in: 1...30))"), views: $viewModel.articleViews)
                
                HStack(alignment: .center, spacing: 10) {
                    viewModel.thumbnail?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 100, maxHeight: 100)
                    
                    Text(viewModel.getArticleTitle())
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.adaptiveText)
                }
                    
                ArticleAuxiliaryDataBar(articleAuxiliaryData: ArticleAuxiliaryData(loved: false, countOfLoved: 0, shared: 0, comments: []), articleURL: viewModel.getArticleURL(), presentingReportSheet: $presentingReportSheet)
            }
        }
        .onTapGesture {
            presentingDestination = true
            destinationURL = viewModel.getArticleURL()
            viewModel.updateViews()
        }
    }
}

#Preview {
    BeatitudoMediaView()
}
