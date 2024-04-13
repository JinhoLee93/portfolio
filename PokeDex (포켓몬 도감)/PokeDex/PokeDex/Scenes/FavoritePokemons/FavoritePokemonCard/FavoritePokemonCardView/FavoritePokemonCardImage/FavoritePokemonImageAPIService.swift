//
//  FavoritePokemonImageDataService.swift
//  PokeDex
//
//  Created by Jinho Lee on 3/12/24.
//

import Foundation
import SwiftUI
import Kingfisher

class FavoritePokemonImageAPIService {
    private let errorIdentifier = "FavoritePokemonImageAPIService"
    
    @Published var favoritePokemonImage: Image? = nil
    
    let favoritePokemon: ViewPokemon
    
    private var imageTask: Task<Void, Error>? = nil
    
    init(domain: NetworkLayer = APIServices.shared, favoritePokemon: ViewPokemon) {    
        self.favoritePokemon = favoritePokemon
        imageTask?.cancel()
        imageTask = Task {
            if let favoritePokemonImage = await fetchFavoritePokemonImage(domain: domain) {
                await MainActor.run { self.favoritePokemonImage = Image(uiImage: favoritePokemonImage) }
            }
        }
    }
}

extension FavoritePokemonImageAPIService {
    private func fetchFavoritePokemonImage(domain: NetworkLayer) async -> UIImage? {
        do {
            if let favoritePokemonImage = try await ImageCache.default.retrieveImageWithConcurrency(domain: domain, pokemonEntry: favoritePokemon.asPokemonEntry()) {
                
                return favoritePokemonImage
            }
        } catch let error {
            print("Error: \(error.localizedDescription) occurred while executing fetchFavoritePokemonImage for \(errorIdentifier).")
        }
        
        return nil
    }
}
