//
//  PokemonEntry.swift
//  PokeDex
//
//  Created by Jinho Lee on 2/12/24.
//

import Foundation

// MARK: - Data Model from the Server
struct PokemonEntry: Codable {
    let name: String
    let url: String
}

extension PokemonEntry {
    func asViewPokemon(isFavorite: Bool = false) -> ViewPokemon {
        return ViewPokemon(self, isFavorite: isFavorite)
    }
}


