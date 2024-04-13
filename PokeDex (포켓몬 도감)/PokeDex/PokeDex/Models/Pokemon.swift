//
//  Pokemon.swift
//  PokeDex
//
//  Created by Jinho Lee on 2/15/24.
//

import Foundation

// MARK: - Data Model from the Server
struct Pokemon: Codable {
    let results: [PokemonEntry]
}

extension Pokemon {
    func appendNewPokemon(_ pokemon: Pokemon) -> Pokemon {
        
        return Pokemon(results: self.results + pokemon.results)
    }
    
    func getOffset() -> Int {
        return self.results.count
    }
}
