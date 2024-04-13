//
//  FavoritePokemonsCardViewModelTest.swift
//  PokeDexTests
//
//  Created by Jinho Lee on 3/16/24.
//

import XCTest
import SwiftUI
import Combine
@testable import PokeDex

final class FavoritePokemonCardViewModelTest: XCTestCase {
    private var mockFavoritePokemonCardViewModel: FavoritePokemonCardViewModel?
    
    private var anyCancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        mockFavoritePokemonCardViewModel = FavoritePokemonCardViewModel(domain: FavoritePokemonsMockAPIService.shared, favoritePokemon: ViewPokemon(name: "mock", url: "mock", isFavorite: true))
    }

    override func tearDownWithError() throws {
        mockFavoritePokemonCardViewModel = nil
    }

    func testFavoritePokemonType() async throws {
        try await Task.sleep(nanoseconds: 3_000_000_000)
        
        mockFavoritePokemonCardViewModel!.$favoritePokemonType
            .sink { mockType in
                XCTAssertEqual(mockType, "mockType")
            }.store(in: &anyCancellables)
    }
}
