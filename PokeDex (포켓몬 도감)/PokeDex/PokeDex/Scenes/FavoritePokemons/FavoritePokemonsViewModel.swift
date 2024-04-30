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
    @Published var readyToShowFavoritePokemons: Bool
    private var favoritePokemonsLoaded: Int
    private var countOfFavoritePokemons: Int
    
    init(favoritePokemons: [ViewPokemon]) {
        self.favoritePokemons = favoritePokemons
        self.readyToShowFavoritePokemons = false
        self.favoritePokemonsLoaded = 0
        self.countOfFavoritePokemons = favoritePokemons.count
    }
    
    func incrementPokemonLoaded() {
        self.favoritePokemonsLoaded += 1
        
        if self.favoritePokemonsLoaded == self.countOfFavoritePokemons {
            readyToShowFavoritePokemons = true
        }
    }
}
