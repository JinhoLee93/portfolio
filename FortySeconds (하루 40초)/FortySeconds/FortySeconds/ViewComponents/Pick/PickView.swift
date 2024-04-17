//
//  PickView.swift
//  FortySeconds
//
//  Created by Jinho Lee on 2/28/22.
//

import SwiftUI

struct PickView: View {
    let letter: FortySeconds.Letter
    var enter: () -> Void
    
    @State var isPressed = false
    var body: some View {
        Button(action: {
            enter()
        }) {
            ZStack {
                let square = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                square.fill().foregroundColor(.white)
                square.strokeBorder(Color.black, lineWidth: DrawingConstants.lineWidth)
                Text(letter.content)
                    .font(.largeTitle)
                    .foregroundColor(.black)
            }
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
