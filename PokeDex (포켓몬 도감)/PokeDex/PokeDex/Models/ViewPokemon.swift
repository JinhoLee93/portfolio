//
//  ViewPokemon.swift
//  PokeDex
//
//  Created by Jinho Lee on 4/30/24.
//

import Foundation

// MARK: - Data Model for Views
struct ViewPokemon: Identifiable, Hashable {
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
