//
//  FavoritePokemonCardViewModel.swift
//  PokeDex
//
//  Created by Jinho Lee on 3/14/24.
//

import Foundation
import Combine

class FavoritePokemonCardViewModel: ObservableObject {
    @Published var favoritePokemonType: String = "unknown"
    
    private var anyCancellables = Set<AnyCancellable>()
    
    private let favoritePokemon: ViewPokemon
    private let domain: FavoritePokemonTypeAPIService
    
    init(domain: NetworkLayer = APIServices.shared, favoritePokemon: ViewPokemon) {
        self.favoritePokemon = favoritePokemon
        self.domain = FavoritePokemonTypeAPIService(domain: domain, favoritePokemon: favoritePokemon)
        self.addSubscribers()
    }
    
    func getFavoritePokemon() -> ViewPokemon {
        
        return self.favoritePokemon
    }
    
    private func addSubscribers() {
        self.domain.$favoritePokemonType
            .sink { [weak self] in
                self?.favoritePokemonType = $0
            }
            .store(in: &anyCancellables)
    }
}
