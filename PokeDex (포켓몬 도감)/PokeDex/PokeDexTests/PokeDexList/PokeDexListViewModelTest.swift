//
//  PokeDexListViewModelTest.swift
//  PokeDexTests
//
//  Created by Jinho Lee on 3/6/24.
//

import XCTest
import RxBlocking
import RxDataSources
@testable import PokeDex

final class PokeDexListViewModelTest: XCTestCase {
    private var mockViewModel: PokeDexListViewModelType?
    
    override func setUpWithError() throws {
        mockViewModel = PokeDexListViewModel(domain: PokeDexListViewMockAPIService.shared)
        let mockViewDidLoad: Void = Void()
        mockViewModel!.callFetchPokemons.onNext(mockViewDidLoad)
    }

    override func tearDownWithError() throws {
        mockViewModel = nil
    }
    
    func test() throws {
        // MARK: - pokemons Test
        let mockPokemon = try mockViewModel!.pokemons.toBlocking().toArray().flatMap { $0 }
        XCTAssertEqual(mockPokemon.count, 21)
        for i in 0..<mockPokemon.count - 1 {
            var pokemonName = "", pokemonURL = ""
            switch i % 5 {
            case 0: pokemonName += "first"; pokemonURL += "first"
            case 1: pokemonName += "second"; pokemonURL += "second"
            case 2: pokemonName += "third"; pokemonURL += "third"
            case 3: pokemonName += "fourth"; pokemonURL += "fourth"
            case 4: pokemonName += "fifth"; pokemonURL += "fifth"
            default:
                XCTAssertThrowsError("Error Indexing Pokemons and URLs for pokemons")
            }
            pokemonName += "Pokemon"; pokemonURL += "URL"
            
            XCTAssertEqual(mockPokemon[i].name, pokemonName)
            XCTAssertEqual(mockPokemon[i].url, pokemonURL)
        }
        
        // MARK: - findPokemonQuery Test
        var mockFindPokemonQuery = "first"
        mockViewModel!.findPokemonQuery.onNext(mockFindPokemonQuery)
        var mockFilteredPokemonByQuery = try mockViewModel!.pokemons.toBlocking().toArray().flatMap { $0 }
        
        XCTAssertEqual(mockFilteredPokemonByQuery.count, 4)
        for i in 0..<mockFilteredPokemonByQuery.count {
            XCTAssertEqual(mockFilteredPokemonByQuery[i].name, "firstPokemon")
            XCTAssertEqual(mockFilteredPokemonByQuery[i].url, "firstURL")
        }

        mockFindPokemonQuery = ""
        mockViewModel!.findPokemonQuery.onNext(mockFindPokemonQuery)
        mockFilteredPokemonByQuery = try mockViewModel!.pokemons.toBlocking().toArray().flatMap { $0 }
        XCTAssertEqual(mockFilteredPokemonByQuery.count, 21)
        for i in 0..<mockFilteredPokemonByQuery.count - 1 {
            var pokemonName = "", pokemonURL = ""
            switch i % 5 {
            case 0: pokemonName += "first"; pokemonURL += "first"
            case 1: pokemonName += "second"; pokemonURL += "second"
            case 2: pokemonName += "third"; pokemonURL += "third"
            case 3: pokemonName += "fourth"; pokemonURL += "fourth"
            case 4: pokemonName += "fifth"; pokemonURL += "fifth"
            default:
                XCTAssertThrowsError("Error Indexing Pokemons and URLs for pokemons")
            }
            pokemonName += "Pokemon"; pokemonURL += "URL"
            
            XCTAssertEqual(mockFilteredPokemonByQuery[i].name, pokemonName)
            XCTAssertEqual(mockFilteredPokemonByQuery[i].url, pokemonURL)
        }
        
        // MARK: - getPokemonAtIndex test
        var mockIndex = IndexPath(row: 1, section: 0)
        mockViewModel!.getPokemonAtIndex.onNext(mockIndex)
        var mockPokemonAtIndex = try mockViewModel!.pokemonAtIndex.toBlocking().single()
        XCTAssertEqual(mockPokemonAtIndex.name, "secondPokemon")
        XCTAssertEqual(mockPokemonAtIndex.url, "secondURL")
        
        mockIndex = IndexPath(row: 5, section: 0)
        mockViewModel!.getPokemonAtIndex.onNext(mockIndex)
        mockPokemonAtIndex = try mockViewModel!.pokemonAtIndex.toBlocking().single()
        XCTAssertEqual(mockPokemonAtIndex.name, "firstPokemon")
        XCTAssertEqual(mockPokemonAtIndex.url, "firstURL")
        
        // MARK: - changeFavorite Test
        let mockViewPokemon = ViewPokemon(name: "mockFavoritePokemon", url: "mockFavoritePokemon", isFavorite: false)
        mockViewModel!.changeFavorite.onNext(mockViewPokemon)
        let mockChangeFavorite = try mockViewModel!.pokemons.toBlocking().toArray().flatMap { $0 }
        for i in 0..<mockChangeFavorite.count {
            if mockChangeFavorite[i].name == "mockFavoritePokemon" {
                XCTAssertEqual(mockChangeFavorite[i].isFavorite, true)
            }
        }
        
        // MARK: - getFavoritePokemons Test
        mockViewModel!.getFavoritePokemonsReady.onNext(Void())
        let mockFavoritePokemons = try mockViewModel!.getFavoritePokemons.toBlocking().toArray().flatMap { $0 }
        XCTAssertEqual(mockFavoritePokemons.count, 1)
    }
}
