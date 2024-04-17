//
//  Shake.swift
//  FortySeconds
//
//  Created by Jinho Lee on 2/27/22.
//

import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                                              y: 0))
    }
}

extension View {
    func shake(_ animatableData: CGFloat) -> some View {
        self.modifier(Shake(animatableData: animatableData))
    }
}
