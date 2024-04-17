//
//  AnyTransition.swift
//  WordsADay
//
//  Created by Jinho Lee on 3/8/22.
//

import SwiftUI

extension AnyTransition {
    static var moveBothWays: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .trailing)
        )
    }
}
