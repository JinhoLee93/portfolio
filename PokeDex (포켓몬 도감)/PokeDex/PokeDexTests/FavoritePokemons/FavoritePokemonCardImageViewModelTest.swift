//
//  FavoritePokemonCardImageViewModelTest.swift
//  PokeDexTests
//
//  Created by Jinho Lee on 3/16/24.
//

import XCTest
import SwiftUI
import Combine
import Kingfisher
@testable import PokeDex

final class FavoritePokemonCardImageViewModelTest: XCTestCase {
    private var mockFavoritePokemonCardImageViewModel: FavoritePokemonCardImageViewModel?
    
    private var anyCancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        ImageCache.default.store(UIImage(named: "Logo")!, forKey: "mockViewPokemon")
        let mockPokemon = ViewPokemon(name: "mock", url: "mockViewPokemon", isFavorite: true)
        mockFavoritePokemonCardImageViewModel = FavoritePokemonCardImageViewModel(domain: FavoritePokemonsMockAPIService.shared, favoritePokemon: mockPokemon)
    }

    override func tearDownWithError() throws {
        mockFavoritePokemonCardImageViewModel = nil
        ImageCache.default.removeImage(forKey: "mockViewPokemon")
    }

    func testFavoritePokemonImage() async throws {
        try await Task.sleep(nanoseconds: 3_000_000_000)
        
        mockFavoritePokemonCardImageViewModel!.$favoritePokemonImage
            .sink { image in
                XCTAssertNotEqual(image, nil)
            }.store(in: &anyCancellables)
    }
}
