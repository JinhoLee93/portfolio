//
//  BeatitudoMediaStatusBar.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/15/24.
//

import SwiftUI

struct BeatitudoMediaStatusBar: View {
    @Binding var showStatusPage: Bool
    
    var body: some View {
        ZStack {
            Color.adaptiveBackground
            
            HStack {
                Spacer()
                
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            showStatusPage = true
                        }
                    }
            }
            .padding(.trailing, 20)
            
        }
        .frame(height: 40)
    }
}

#Preview {
    BeatitudoMediaView()
}
