//
//  ArticleBar.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import SwiftUI

struct ArticleAuxiliaryDataBar: View {
    @StateObject private var viewModel: ArticleAuxiliaryDataViewModel
    
    init(articleAuxiliaryData: ArticleAuxiliaryData) {
        _viewModel = StateObject(wrappedValue:
                                    ArticleAuxiliaryDataViewModel(articleAuxiliaryData: articleAuxiliaryData))
    }
    
    var body: some View {
        ZStack {
            HStack(spacing: 5) {
                HStack(spacing: 5) {
                    Image(systemName: self.viewModel.getLoved() ? "heart.fill" : "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(self.viewModel.getLoved() ? .pink : .black)
                    
                    Text("\(self.viewModel.getCountOfLoved())")
                        .font(.system(size: 15))
                        .foregroundStyle(self.viewModel.getLoved() ? .pink : .black)
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(self.viewModel.getLoved() ? .pink : .black)
                )
                .onTapGesture {
                    self.viewModel.updateLoved()
                }
                
                Spacer()
                
                HStack(spacing: 5) {
                    Image(systemName: "text.bubble")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    
                    Text("\(self.viewModel.getCommentsCount())")
                        .font(.system(size: 15))
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.black)
                )
                
                HStack(spacing: 5) {
                    Image(systemName: "arrowshape.turn.up.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    
                    Text("\(self.viewModel.getShared())")
                        .font(.system(size: 15))
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.black)
                )
            }
        }
    }
}

#Preview {
    BeatitudoMediaView()
}
