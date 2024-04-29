//
//  LoadingPage.swift
//  PokeDex
//
//  Created by Jinho Lee on 4/29/24.
//

import SwiftUI

struct LoadingPage: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.4)
                .blur(radius: 30)
            LoadingIcon()
        }
    }
}

#Preview {
    LoadingPage()
}
