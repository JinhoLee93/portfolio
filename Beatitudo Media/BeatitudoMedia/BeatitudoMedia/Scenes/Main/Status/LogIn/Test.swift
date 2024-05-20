//
//  Test.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/20/24.
//

import SwiftUI

struct Test: View {
    @State var presentingLogInView = false
    
    var body: some View {
        ZStack {
            Color.white
            
            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    presentingLogInView = true
                }
            } label: {
                Text("PPPP")
            }
            
            BeatitudoMediaLogInView(showLogInPage: $presentingLogInView)
        }
    }
}

#Preview {
    Test()
}
