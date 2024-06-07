//
//  BeatitudoMediaProgressView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/22/24.
//

import SwiftUI

struct BeatitudoMediaProgressView: View {
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.4)
            
            ProgressView()
        }
        .disabled(true)
    }
}

#Preview {
    BeatitudoMediaProgressView()
}
