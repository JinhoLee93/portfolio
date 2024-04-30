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
        ZStack {
            LoadingPage()
                .opacity(viewModel.readyToShowFavoritePokemons ? 0 : 1)
            VStack {
                VStack {
                    Text("Your Favorite Pokemons")
                        .fontWeight(.bold)
                        .foregroundStyle(.yellow)
                }
                .frame(height: 40)
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.getArrayOfPokemonsChoppedByThree(), id: \.self) { favoritePokemonsChoppedByThree in
                            HStack(spacing: 10) {
                                ForEach(favoritePokemonsChoppedByThree) { favoritePokemon in
                                    FavoritePokemonCardView(favoritePokemon: favoritePokemon)
                                        .environmentObject(viewModel)
                                }
                            }
                        }
                    }
                    .padding(10)
                }
                .opacity(viewModel.readyToShowFavoritePokemons ? 1 : 0)
            }
        }
    }
}

#Preview {
    FavoritePokemonsView(favoritePokemons: [])
}
