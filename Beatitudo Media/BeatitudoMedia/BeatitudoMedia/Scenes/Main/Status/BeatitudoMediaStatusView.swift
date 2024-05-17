//
//  BeatitudoMediaStatusView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/15/24.
//

import SwiftUI

struct BeatitudoMediaStatusView: View {
    @Binding var showStatusPage: Bool
    
    var body: some View {
        ZStack {
            Color.adaptiveBackground
            
            Image(systemName: "line.3.horizontal")
            
        }
        .frame(height: 40)
    }
}

#Preview {
    BeatitudoMediaView()
}
