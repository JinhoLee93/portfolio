//
//  FavoritePokemonsViewModelTest.swift
//  PokeDexTests
//
//  Created by Jinho Lee on 3/16/24.
//

import XCTest
import SwiftUI
import Combine
@testable import PokeDex

final class FavoritePokemonsViewModelTest: XCTestCase {
    private var mockFavoritePokemonViewModel: FavoritePokemonsViewModel?
    
    private var anyCancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        var mockfavoritePokemons: [ViewPokemon] = []
        for _ in 0..<5 {
            mockfavoritePokemons.append(ViewPokemon(name: "firstPokemon", url: "firstURL", isFavorite: true))
            mockfavoritePokemons.append(ViewPokemon(name: "secondPokemon", url: "secondURL", isFavorite: true))
            mockfavoritePokemons.append(ViewPokemon(name: "thirdPokemon", url: "thirdURL", isFavorite: true))
            mockfavoritePokemons.append(ViewPokemon(name: "fourthPokemon", url: "fourthURL", isFavorite: true))
        }
        mockFavoritePokemonViewModel = FavoritePokemonsViewModel(favoritePokemons: mockfavoritePokemons)
    }

    override func tearDownWithError() throws {
        mockFavoritePokemonViewModel = nil
    }

    func testFavoritePokemons() throws {
        mockFavoritePokemonViewModel!.$favoritePokemons
            .sink { mockFavoritePokemons in
                XCTAssertEqual(mockFavoritePokemons.count, 20)
                for i in 0..<mockFavoritePokemons.count {
                    var pokemonName = "", pokemonURL = ""
                    switch i % 4 {
                    case 0: pokemonName += "first"; pokemonURL += "first"
                    case 1: pokemonName += "second"; pokemonURL += "second"
                    case 2: pokemonName += "third"; pokemonURL += "third"
                    case 3: pokemonName += "fourth"; pokemonURL += "fourth"
                    default:
                        XCTAssertThrowsError("Error Indexing Pokemons and URLs for pokemons")
                    }
                    pokemonName += "Pokemon"; pokemonURL += "URL"
                    
                    XCTAssertEqual(mockFavoritePokemons[i].name, pokemonName)
                    XCTAssertEqual(mockFavoritePokemons[i].url, pokemonURL)
                }
            }.store(in: &anyCancellables)
            
    }
}
