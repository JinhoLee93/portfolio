//
//  FavoritePokemonCardImageViewModel.swift
//  PokeDex
//
//  Created by Jinho Lee on 3/12/24.
//

import Foundation
import SwiftUI
import Combine
import Kingfisher

class FavoritePokemonCardImageViewModel: ObservableObject {
    @Published var favoritePokemonImage: Image? = nil
    
    private var anyCancellables = Set<AnyCancellable>()
    
    private let favoritePokemon: ViewPokemon
    private let domain: FavoritePokemonImageAPIService

    init(domain: NetworkLayer = APIServices.shared, favoritePokemon: ViewPokemon) {
        self.favoritePokemon = favoritePokemon
        self.domain = FavoritePokemonImageAPIService(domain: domain, favoritePokemon: favoritePokemon)
        self.addSubscriber()
    }
    
    private func addSubscriber() {
        self.domain.$favoritePokemonImage
            .sink { [weak self] in
                self?.favoritePokemonImage = $0
            }
            .store(in: &anyCancellables)
    }
}

