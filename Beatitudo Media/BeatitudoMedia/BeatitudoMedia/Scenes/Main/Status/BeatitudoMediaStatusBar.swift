//
//  BeatitudoMediaStatusBar.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/15/24.
//

import SwiftUI

struct BeatitudoMediaStatusBar: View {
    @Binding var showStatusPage: Bool
    
    @Binding var isLightModeOn: Bool
    
    var body: some View {
        ZStack {
            Color.adaptiveBackground
            
            HStack {
                Image(systemName: isLightModeOn ? "sun.max.fill" : "moon.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .shadow(color: isLightModeOn ? Color.yellow : Color.white, radius: 10, x: 0.0, y: 0.0)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            isLightModeOn.toggle()
                        }
                        GlobalAssets.isLightModeOn.toggle()
                    }
                
                Spacer()
            }
            .padding(.leading, 20)
            
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
    BeatitudoMediaView(isLightModeOn: .constant(false))
}
