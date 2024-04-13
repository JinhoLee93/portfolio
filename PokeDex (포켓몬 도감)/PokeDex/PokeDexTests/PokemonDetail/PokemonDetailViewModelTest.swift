//
//  PokemonDetailViewModelTest.swift
//  PokeDexTests
//
//  Created by Jinho Lee on 3/9/24.
//

import XCTest
import RxBlocking
import Kingfisher
import RxDataSources
@testable import PokeDex

final class PokemonDetailViewModelTest: XCTestCase {
    private var mockViewModel: PokemonDetailViewModelType?
    
    override func setUpWithError() throws {
        ImageCache.default.store(UIImage(named: "Logo")!, forKey: "mockViewPokemon")
        let mockViewPokemon = ViewPokemon(name: "mockViewPokemon", url: "mockURL", isFavorite: false)
        mockViewModel = PokemonDetailViewModel(domain: PokemonDetailMockAPIService.shared, viewPokemon: mockViewPokemon)
    }

    override func tearDownWithError() throws {
        ImageCache.default.removeImage(forKey: "mockViewPokemon")
        mockViewModel = nil
    }

    // MARK: - pokemonImage Test
    func testPokemonImage() throws {
        let mockPokemonImage = try mockViewModel!.pokemonImage.toBlocking().toArray().compactMap { $0 }
        XCTAssertTrue(mockPokemonImage.count > 0)
    }
    
    // MARK: - pokemonName Test
    func testPokemonName() throws {
        let mockPokemonName = try mockViewModel!.pokemonName.toBlocking().single()
        XCTAssertEqual(mockPokemonName, "mockViewPokemon")
    }
    
    // MARK: - pokemonType Test
    func testPokemonType() throws {
        let mockPokemonType = try mockViewModel!.pokemonType.toBlocking().toArray()
        XCTAssertEqual(mockPokemonType.last, "mockType")
    }
    
    // MARK: - pokemonAbilities Test
    func testPokemonAbilities() throws {
        let mockPokemonAbilities = try mockViewModel!.pokemonAbilities.toBlocking().toArray().flatMap { $0 }
        XCTAssertEqual(mockPokemonAbilities.count, 5)
        for i in 0..<5 {
            let test = "ability\(i + 1)"
            XCTAssertEqual(mockPokemonAbilities[i].ability.name, test)
        }
    }
    
    // MARK: - PokemonMoves Test
    func testPokemonMoves() throws {
        let mockPokemonMoves = try mockViewModel!.pokemonMoves.toBlocking().toArray().flatMap { $0 }
        XCTAssertEqual(mockPokemonMoves.count, 5)
        for i in 0..<5 {
            let test = "move\(i + 1)"
            XCTAssertEqual(mockPokemonMoves[i].move.name, test)
        }
    }
    
    // MARK: - pokemonDetailSections Test
    func testPokemonDetailSections() throws {
        let mockPokemonDetailSections = try mockViewModel!.pokemonDetailSections.toBlocking().toArray().flatMap { $0 }
        XCTAssertEqual(mockPokemonDetailSections.count, 2)
        XCTAssertEqual(mockPokemonDetailSections[0].items.count, 5)
        XCTAssertEqual(mockPokemonDetailSections[1].items.count, 5)
        
        let mockAbilityItems = mockPokemonDetailSections[0].items.sorted()
        for i in 0..<5 {
            let mockAbility = "ability\(i + 1)"
            XCTAssertEqual(mockAbilityItems[i], mockAbility)
        }
        
        let mockMoveItems = mockPokemonDetailSections[1].items.sorted()
        for i in 0..<5 {
            let mockMove = "move\(i + 1)"
            XCTAssertEqual(mockMoveItems[i], mockMove)
        }
    }
}
