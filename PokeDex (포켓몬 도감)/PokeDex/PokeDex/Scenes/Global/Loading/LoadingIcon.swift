//
//  LoadingIcon.swift
//  PokeDex
//
//  Created by Jinho Lee on 4/28/24.
//

import SwiftUI
import Combine

struct LoadingIcon: View {
    @State var isAnimating = false
    @State var queRotation = false
    @State var imageRotation: Double = 0.0
    
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .offset(y: isAnimating ? -20 : 0.0)
                .rotation3DEffect(
                    Angle(degrees: queRotation ? 360.0 : 0.0),
                    axis: (x: 0.0, y: 1.0, z: 0.0),
                    perspective: 0
                )
            
            Button(action: {
                withAnimation(.easeInOut(duration: isAnimating ? 0.2 : 0.5).repeatForever(autoreverses: true)) {
                    isAnimating.toggle()
                }
            }, label: {
                Text("Animate")
            })
            
            Button(action: {
                isAnimating = false
            }, label: { Text("Stop") })
        }
    }
}

#Preview {
    LoadingIcon()
}
