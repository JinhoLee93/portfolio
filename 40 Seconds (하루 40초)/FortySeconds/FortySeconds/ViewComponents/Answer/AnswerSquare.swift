//
//  AnswerSquare.swift
//  FortySeconds
//
//  Created by Jinho Lee on 4/5/22.
//

import SwiftUI

struct AnswerSquare: View {
    let letter: FortySeconds.Letter
    var shouldFlip: Bool
    let answerBuffer: Array<FortySeconds.Letter>
    
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0
    @State var scale: CGFloat = 1
    @State var flipped: Bool = false
    @State var textFlipped: Bool = false

    init(letter: FortySeconds.Letter, isMatched: Bool, answerBuffer: Array<FortySeconds.Letter>) {
        self.letter = letter
        self.shouldFlip = isMatched
        self.answerBuffer = answerBuffer
    }
    
    var body: some View {
        ZStack {
            let square = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            square.fill().foregroundColor(flipped ? .green : .white).opacity(flipped ? 0.5 : 1)
            square.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(flipped ? .green : .black)
            Text(letter.content)
                .foregroundColor(textFlipped ? .white : .black)
                .font(.largeTitle)
        }
        .scaleEffect(scale)
        .rotation3DEffect(Angle.degrees(contentRotation), axis: (0, 1, 0), perspective: 0)
        .rotation3DEffect(Angle.degrees(flashcardRotation), axis: (0, 1, 0), perspective: 0)
        .frame(width: DrawingConstants.frameWidth, height: DrawingConstants.frameHeight)
        .onChange(of: letter.content) { _ in
            if letter.content == "" {
                withAnimation(Animation.easeInOut(duration: 0.1).repeatCount(1)) {
                    scale = 0.8
                }
                scale = 1
            }
        }
        .onChange(of: shouldFlip) { _ in
            Task {
                await prepFlip()
            }
        }
    }
    
    private func delay(for letter: FortySeconds.Letter) -> Double {
        var delay = 0.0
        if let index = answerBuffer.firstIndex(where: { $0.id == letter.id }) {
            delay = Double(index) * (0.3 / Double(answerBuffer.count))
        }
        
        return delay
    }
    
    struct DrawingConstants {
        static let lineWidth: CGFloat = 4.5
        static let cornerRadius: CGFloat = 20
        static let frameWidth: CGFloat = 68
        static let frameHeight: CGFloat = 68
    }
}

extension AnswerSquare {
    @MainActor
    func prepFlip() async {
        try? await Task.sleep(for: delay(for: letter))
        let duration: Double = 0.3
        await flip(for: duration)
    }
    
    @MainActor
    func flip(for duration: Double) async {
        withAnimation(Animation.linear(duration: duration)) {
            flashcardRotation += 180
            Task {
                try? await Task.sleep(for: duration / 2)
                textFlipped.toggle()
            }
        }
        
        withAnimation(Animation.linear(duration: duration / 100).delay(duration / 2)) {
            contentRotation += 180
            flipped.toggle()
        }
    }
}
