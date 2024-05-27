//
//  StatusMenuBar.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/26/24.
//

import SwiftUI

struct StatusMenuBar: View {
    @StateObject private var viewModel: StatusMenuBarViewModel
    
    init(menuTitle: String) {
        self._viewModel = StateObject(wrappedValue: StatusMenuBarViewModel(menuTitle: menuTitle))
    }
    
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                Color.adaptiveBackground
                
                HStack {
                    Image(systemName: "\(viewModel.iconTitle)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 20)
                        .foregroundStyle(.adaptiveView)
                    
                    Text("\(viewModel.menuTitle)")
                        .font(.system(size: 20))
                        .foregroundStyle(.adaptiveText)
                    
                    Spacer()
                }
                .padding(.leading, 20)
                
            }
        }
    }
}


#Preview {
    StatusMenuBar(menuTitle: "profile")
}
