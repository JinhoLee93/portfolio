//
//  FavoritePokemonsViewModel.swift
//  PokeDex
//
//  Created by Jinho Lee on 3/12/24.
//

import Foundation
import Combine

class FavoritePokemonsViewModel: ObservableObject {
    @Published var favoritePokemons: [ViewPokemon]
    
    init(favoritePokemons: [ViewPokemon]) {
        self.favoritePokemons = favoritePokemons
    }
}
