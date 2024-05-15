//
//  StatusView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/15/24.
//

import SwiftUI

struct StatusView: View {
    @Binding var showStatusPage: Bool
    
    var body: some View {
        ZStack {
            Color.adaptiveBackground
            
            Image(systemName: "line.3.horizontal")
                .onTapGesture {
                    showStatusPage = true
                }
            
        }
        .frame(height: 40)
    }
}

#Preview {
    BeatitudoMediaView()
}
