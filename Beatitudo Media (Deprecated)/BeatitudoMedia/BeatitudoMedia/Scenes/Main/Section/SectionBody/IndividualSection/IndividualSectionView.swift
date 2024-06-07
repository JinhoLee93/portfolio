//
//  IndividualSectionView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/31/24.
//

import SwiftUI

struct IndividualSectionView: View {
    @StateObject private var viewModel: IndividualSectionViewModel
    
    @Binding var presentingDestination: Bool
    @Binding var destinationURL: String
    @Binding var presentingReportSheet: Bool
    @Binding var isUserSignedIn: Bool
    @Binding var showSigningSheet: Bool
    
    init(individualSection: Section, presentingDestination: Binding<Bool>, destinationURL: Binding<String>, presentingReportSheet: Binding<Bool>, isUserSignedIn: Binding<Bool>, showSigningSheet: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: IndividualSectionViewModel(individualSection: individualSection))
        self._presentingDestination = presentingDestination
        self._destinationURL = destinationURL
        self._presentingReportSheet = presentingReportSheet
        self._isUserSignedIn = isUserSignedIn
        self._showSigningSheet = showSigningSheet
    }
    
    var body: some View {
        BeatitudoMediaScrollView {
            ForEach(viewModel.individualSection.articles, id: \.self) { article in
                ArticleView(article: article, presentingDestination: $presentingDestination, destinationURL: $destinationURL, presentingReportSheet: $presentingReportSheet, isUserSignedIn: $isUserSignedIn, showSigningSheet: $showSigningSheet)
            }
        } onRefresh: {
            try await viewModel.fetchIndividualSection()
        }
    }
}

//#Preview {
//    IndividualSectionView()
//}
