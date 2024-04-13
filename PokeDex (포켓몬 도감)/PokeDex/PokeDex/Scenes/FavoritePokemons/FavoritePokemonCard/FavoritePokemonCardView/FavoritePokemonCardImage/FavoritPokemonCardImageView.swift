//
//  FavoritePokemonCardImageView.swift
//  PokeDex
//
//  Created by Jinho Lee on 3/12/24.
//

import SwiftUI

// MARK: - Shows the Image of the Favorite Pokemon
struct FavoritePokemonCardImageView: View {
    @StateObject var viewModel: FavoritePokemonCardImageViewModel
    
    init(favoritePokemon: ViewPokemon) {
        _viewModel = StateObject(wrappedValue: FavoritePokemonCardImageViewModel(favoritePokemon: favoritePokemon))
    }
    
    var body: some View {
        if let favoritePokemonImage = viewModel.favoritePokemonImage {
            favoritePokemonImage
                .resizable()
                .frame(width: 100, height: 100)
        } else {
            Image("Loading")
                .resizable()
                .frame(width: 75, height: 75)
                .padding(EdgeInsets(top: 12.5, leading: 12.5, bottom: 12.5, trailing: 12.5))
        }
    }
}

#Preview {
    FavoritePokemonCardImageView(favoritePokemon: ViewPokemon(name: "ditto", url: "https://pokeapi.co/api/v2/pokemon/ditto", isFavorite: false))
}
