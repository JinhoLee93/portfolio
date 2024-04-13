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

// MARK: - Data Model for Views
struct ViewPokemon: Identifiable {
    let id = UUID()
    let name: String
    let url: String
    let isFavorite: Bool
    
    init(_ entry: PokemonEntry, isFavorite: Bool) {
        self.name = entry.name
        self.url = entry.url
        self.isFavorite = isFavorite
    }
    
    init(name: String, url: String, isFavorite: Bool) {
        self.name = name
        self.url = url
        self.isFavorite = isFavorite
    }
    
    func asPokemonEntry() -> PokemonEntry {
        return PokemonEntry(name: self.name, url: self.url)
    }
    
    func changeIsFavorite(isFavorite: Bool) -> ViewPokemon {
        return ViewPokemon(name: self.name, url: self.url, isFavorite: isFavorite)
    }
}

