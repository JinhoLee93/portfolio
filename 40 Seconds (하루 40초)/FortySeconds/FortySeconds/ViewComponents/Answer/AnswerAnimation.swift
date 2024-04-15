//
//  AnswerAnimation.swift
//  FortySeconds
//
//  Created by Jinho Lee on 4/5/22.
//

import SwiftUI

struct AnswerAnimation: Animatable, ViewModifier {
    
    init(isMatched: Bool) {
        rotation = isMatched ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
}

extension View {
    func answerfy(isMatched: Bool) -> some View {
        self.modifier(AnswerAnimation(isMatched: isMatched))
    }
}
