//
//  SplashScreen.swift
//  FortySeconds
//
//  Created by Jinho Lee on 2/28/22.
//

import SwiftUI

struct SplashScreen: View {
    @State var isUp = false
    
    var body: some View {
        Spacer()
        Image("40secsLogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotationEffect(Angle.degrees(isUp ? 25:0))
            .animation(.easeInOut(duration: 0.5), value: isUp)
            .onAppear {
                withAnimation {
                    isUp.toggle()
                }
            }
        
        Spacer()
        VStack {
            Text("Created by Jinho Lee")
                .frame(alignment: .bottom)
                .font(.headline)
        }
    }
}

