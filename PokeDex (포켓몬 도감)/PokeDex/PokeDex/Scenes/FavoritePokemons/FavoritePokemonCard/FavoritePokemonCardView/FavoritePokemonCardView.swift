//
//  FavoritePokemonCardView.swift
//  PokeDex
//
//  Created by Jinho Lee on 3/14/24.
//

import SwiftUI

// MARK: - Turns the Favorite Pokemon into a Card
struct FavoritePokemonCardView: View {
    @StateObject var viewModel: FavoritePokemonCardViewModel
    @EnvironmentObject var environmentViewModel: FavoritePokemonsViewModel
    
    init(favoritePokemon: ViewPokemon) {
        _viewModel = StateObject(wrappedValue: FavoritePokemonCardViewModel(favoritePokemon: favoritePokemon))
    }
    
    var body: some View {
        if viewModel.successfullyLoaded {
            ZStack {
                VStack {
                    Text(viewModel.getFavoritePokemon().name.localizedCapitalized)
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white.opacity(0.25))
                        }
                    
                    FavoritePokemonCardImageView(favoritePokemon: viewModel.getFavoritePokemon())
                        .scaledToFit()
                }
                .frame(minWidth: 120, maxWidth: 120, minHeight: 150)
                .background(TypeColorPattern(rawValue: viewModel.favoritePokemonType)!.typeToColor)
            }
            .clipShape(.rect(cornerRadius: 15))
            .shadow(color: TypeColorPattern(rawValue: viewModel.favoritePokemonType)!.typeToColor, radius: 5, x: 0.0, y: 0.0)
            .onAppear {
                environmentViewModel.incrementPokemonLoaded()
            }
        }
    }
}

#Preview {
    FavoritePokemonCardView(favoritePokemon: ViewPokemon(name: "ditto", url: "https://pokeapi.co/api/v2/pokemon/ditto", isFavorite: false))
}
