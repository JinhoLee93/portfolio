//
//  SquareView.swift
//  FortySeconds
//
//  Created by Jinho Lee on 2/27/22.
//

import SwiftUI

struct SquareView: View {
    let letter: FortySeconds.Letter
    
    var body: some View {
        ZStack {
            let square = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            square.fill().foregroundColor(.white)
            square.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            Text(letter.content)
                .font(.largeTitle)
        }
        .frame(width: DrawingConstants.frameWidth, height: DrawingConstants.frameHeight)
    }
    
    struct DrawingConstants {
        static let lineWidth: CGFloat = 4.5
        static let cornerRadius: CGFloat = 20
        static let frameWidth: CGFloat = 68
        static let frameHeight: CGFloat = 68
    }
}
