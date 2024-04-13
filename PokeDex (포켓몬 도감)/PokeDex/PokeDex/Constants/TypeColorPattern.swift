//
//  TypeColorPattern.swift
//  PokeDex
//
//  Created by Jinho Lee on 3/14/24.
//

import Foundation
import SwiftUI

// MARK: - Converts Pokemon types to their related colors.
enum TypeColorPattern: String {
    case fire = "fire"
    case dragon = "dragon"
    case fighting = "fighting"
    case grass = "grass"
    case bug = "bug"
    case water = "water"
    case ice = "ice"
    case poison = "poison"
    case ghost = "ghost"
    case ground = "ground"
    case rock = "rock"
    case fairy = "fairy"
    case flying = "flying"
    case electric = "electric"
    case psychic = "psychic"
    case steele = "steele"
    case dark = "dark"
    case normal = "normal"
    case unknown = "unknown"
    
    var typeToColor: Color {
        switch self {
        case .fire:
            Color.red
        case .dragon:
            Color.red
        case .fighting:
            Color.red
        case .grass:
            Color.green
        case .bug:
            Color.green
        case .water:
            Color.blue
        case .ice:
            Color.blue
        case .poison:
            Color.purple
        case .ghost:
            Color.purple
        case .ground:
            Color.brown
        case .rock:
            Color.brown
        case .fairy:
            Color.cyan
        case .flying:
            Color.cyan
        case .psychic:
            Color.yellow
        case .electric:
            Color.yellow
        case .steele:
            Color.gray
        case .dark:
            Color.black
        case .normal:
            Color.indigo
        case .unknown:
            Color.indigo
        }
    }
}
