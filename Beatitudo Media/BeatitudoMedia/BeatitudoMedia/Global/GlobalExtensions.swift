//
//  GlobalExtensions.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/23/24.
//

import Foundation
import SwiftUI

// MARK: - View
extension View {
    func clipShapeAndStrokeBorderWithRoundedRectangle(cornerRadius: CGFloat, borderColor: Color) -> some View {
        let roundedRectangle = RoundedRectangle(cornerRadius: cornerRadius)
        
        return clipShape(roundedRectangle).overlay(roundedRectangle.strokeBorder(borderColor))
    }
}

extension View {
    func offset(coordinateSpace: String, offset: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named(coordinateSpace)).minY
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                        .onPreferenceChange(OffsetKey.self) { value in
                            offset(value)
                        }
                }
            }
    }
}
