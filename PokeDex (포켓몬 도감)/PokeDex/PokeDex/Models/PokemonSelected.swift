//
//  PokemonSelected.swift
//  PokeDex
//
//  Created by Jinho Lee on 2/17/24.
//

import Foundation
import UIKit


// MARK: - Data Model from the Server 
struct PokemonSelected: Codable {
    let sprites: PokemonSprites
    let types: [PokemonType]
    let abilities: [PokemonAbility]
    let moves: [PokemonMove]
}

// Fill these up
struct PokemonAbility: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

struct PokemonMove: Codable {
    let move: Move
}

struct Move: Codable {
    let name: String
}

struct PokemonType: Codable {
    let type: TypeElement
}

struct TypeElement: Codable {
    let name: String
}

struct PokemonSprites: Codable {
    let frontDefault: String?
    let other: Other
}

struct Other: Codable {
    let officialArtwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String?
}
