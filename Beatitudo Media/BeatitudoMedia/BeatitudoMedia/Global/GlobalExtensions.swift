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
