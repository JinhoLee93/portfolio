//
//  BeatitudoMediaSplashView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/1/24.
//

import SwiftUI

struct BeatitudoMediaSplashView: View {
    var body: some View {
        ZStack {
            HStack {
                Text("소중한 당신의 마음이, \n조금 더 따뜻해 질 수 있도록")
                    .font(.system(size: 20))
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Text(Utils.getToday())
                    .bold()
                
                Spacer()
                    .frame(height: 50)
            }
        }
        .ignoresSafeArea()
        
        // Add a picture or a drawing of a flower.
    }
}

#Preview {
    BeatitudoMediaSplashView()
}
