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
    @State var timer: Timer?
    @State var bounced = 0
    
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
                .onAppear {
                    withAnimation(.easeInOut(duration: isAnimating ? 0.2 : 0.5).repeatForever(autoreverses: true)) {
                        isAnimating.toggle()
                        bounced += 1
                    }
                    
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        bounced += 1
                        if bounced == 3 {
                            bounced = 0
                            withAnimation(.easeInOut(duration: 0.5)) {
                                queRotation.toggle()
                            }
                        }
                    }
                }
        }
    }
}

#Preview {
    LoadingIcon()
}
