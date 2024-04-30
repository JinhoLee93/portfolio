//
//  FavoritePokemonTypeAPIService.swift
//  PokeDex
//
//  Created by Jinho Lee on 3/14/24.
//

import Foundation

class FavoritePokemonTypeAPIService: ObservableObject {
    private let errorIdentifier = "FavoritePokemonTypeAPIService"
    
    @Published var favoritePokemonType: String?
    
    let favoritePokemon: ViewPokemon
    let domain: NetworkLayer
    
    private var typeTask: Task<Void, Error>? = nil
    
    init(domain: NetworkLayer = APIServices.shared, favoritePokemon: ViewPokemon) {
        self.favoritePokemon = favoritePokemon
        self.domain = domain
        typeTask?.cancel()
        typeTask = Task {
            if let type = await fetchFavoritePokemonType() {
                await MainActor.run { self.favoritePokemonType = type }
            }
        }
    }
}

extension FavoritePokemonTypeAPIService {
    private func fetchFavoritePokemonType() async -> String? {
        do {
            if let pokemonSelected: PokemonSelected = try await domain.fetchData(url: favoritePokemon.url) {
                
                return pokemonSelected.types[0].type.name
            }
        } catch let error {
            print("Error: \(error.localizedDescription) occurred while executing fetchFavoritePokemonType for \(errorIdentifier).")
        }
        
        return nil
    }
}
