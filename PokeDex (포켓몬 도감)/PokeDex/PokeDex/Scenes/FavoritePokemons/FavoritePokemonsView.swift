//
//  FavoritePokemonsView.swift
//  PokeDex
//
//  Created by Jinho Lee on 3/12/24.
//

import SwiftUI
import Combine

// MARK: - Shows the Entire Page of Favorite Pokemon Cards
struct FavoritePokemonsView: View {
    @StateObject var viewModel: FavoritePokemonsViewModel
    
    init(favoritePokemons: [ViewPokemon]) {
        _viewModel = StateObject(wrappedValue: FavoritePokemonsViewModel(favoritePokemons: favoritePokemons))
    }
    
    private let gridItems = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        VStack {
            Text("Your Favorite Pokemons")
                .fontWeight(.bold)
                .foregroundStyle(.yellow)
        }
        .frame(height: 40)
        ScrollView {
            LazyVGrid(columns: gridItems) {
                ForEach(viewModel.favoritePokemons) { favoritePokemon in
                    FavoritePokemonCardView(favoritePokemon: favoritePokemon)
                }
            }
            .padding(10)
        }
    }
}

#Preview {
    FavoritePokemonsView(favoritePokemons: [])
}
