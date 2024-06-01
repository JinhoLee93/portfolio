//
//  BeatitudoMediaSplashView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/1/24.
//

import SwiftUI

struct BeatitudoMediaSplashView: View {
    @Binding var showSplashDate: Bool
    
    var body: some View {
        ZStack {
            Color.adaptiveBackground
            
            HStack {
                Text("소중한 당신의 마음이, \n조금 더 따뜻해 질 수 있도록")
                    .font(.system(size: 20))
                    .foregroundStyle(.adaptiveText)
                
                Spacer()
            }
            .padding(.leading, 10)
            
            VStack {
                Spacer()
                
                Text(Utils.getToday())
                    .opacity(showSplashDate ? 1 : 0)
                    .bold()
                    .foregroundStyle(.adaptiveText)
                
                Spacer()
                    .frame(height: 20)
            }
        }
        .ignoresSafeArea()
        
        // Add a picture or a drawing of a flower.
    }
}

#Preview {
    BeatitudoMediaSplashView(showSplashDate: .constant(true))
}
