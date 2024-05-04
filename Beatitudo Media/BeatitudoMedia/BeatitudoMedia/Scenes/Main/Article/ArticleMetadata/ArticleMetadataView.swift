//
//  ArticleMetaView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import SwiftUI

struct ArticleMetadataView: View {
    @StateObject private var viewModel: ArticleMetadataViewModel
    
    init(articleMetadata: ArticleMetadata) {
        _viewModel = StateObject(wrappedValue: ArticleMetadataViewModel(articleMetadata: articleMetadata))
    }
    
    var body: some View {
        HStack(spacing: 10) {
            HStack(spacing: 5) {
                Image(systemName: "clock")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                
                Text("\(viewModel.articleMetadata.timeToRead)분 독서")
                    .font(.system(size: 15))
                    .foregroundStyle(.adaptiveText)
            }
            
            Spacer()
            
            HStack(spacing: 5) {
                Image(systemName: "eye")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.gray)
                
                Text("\(viewModel.articleMetadata.views)")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
            }

            HStack(spacing: 5) {
                Image(systemName: "calendar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.gray)
                
                Text(viewModel.articleMetadata.date)
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    BeatitudoMediaView()
}
