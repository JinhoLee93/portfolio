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
    @Binding var isUserSignedIn: Bool
    @Binding var showSigningSheet: Bool
    
    @State private var signalArticleViews: Bool = false
    
    init(article: Article, presentingDestination: Binding<Bool>, destinationURL: Binding<String>, presentingReportSheet: Binding<Bool>, isUserSignedIn: Binding<Bool>, showSigningSheet: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: ArticleViewModel(article: article))
        self._presentingDestination = presentingDestination
        self._destinationURL = destinationURL
        self._presentingReportSheet = presentingReportSheet
        self._isUserSignedIn = isUserSignedIn
        self._showSigningSheet = showSigningSheet
    }
    
    var body: some View {
        ZStack {
            Color.adaptiveBackground
            
            VStack(alignment: .leading, spacing: 5) {
                ArticleMetadataView(articleMetadata: viewModel.getArticleMetaData(), signalArticleViews: $signalArticleViews)
                
                HStack(alignment: .center, spacing: 10) {
                    viewModel.thumbnail?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                    
                    Text(viewModel.getArticleTitle())
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.adaptiveText)
                }
                    
                ArticleAuxiliaryDataBar(articleAuxiliaryData: viewModel.getArticleAuxiliaryData(), articleURL: viewModel.getArticleURL(), presentingReportSheet: $presentingReportSheet, isUserSignedIn: $isUserSignedIn, showSigningSheet: $showSigningSheet)
            }
        }
        .onTapGesture {
            signalArticleViews.toggle()
            presentingDestination = true
            destinationURL = viewModel.getArticleURL()
        }
    }
}

#Preview {
    BeatitudoMediaView()
}
