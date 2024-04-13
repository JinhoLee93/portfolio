//
//  MockAPIService.swift
//  PokeDexTests
//
//  Created by Jinho Lee on 3/9/24.
//

import Foundation
import UIKit
@testable import PokeDex

final class PokeDexListViewMockAPIService: NetworkLayer {
    static let shared = PokeDexListViewMockAPIService()
    
    private init() { }
    
    func fetchData<T: Decodable>(url: String) -> T {
        
        return "" as! T
    }
    
    func fetchBoundedData<T: Decodable>(offset: Int, limit: Int) -> T {
        var testPokemonResults: [PokemonEntry] = []
        
        for _ in 0..<4 {
            testPokemonResults.append(PokemonEntry(name: "firstPokemon", url: "firstURL"))
            testPokemonResults.append(PokemonEntry(name: "secondPokemon", url: "secondURL"))
            testPokemonResults.append(PokemonEntry(name: "thirdPokemon", url: "thirdURL"))
            testPokemonResults.append(PokemonEntry(name: "fourthPokemon", url: "fourthURL"))
            testPokemonResults.append(PokemonEntry(name: "fifthPokemon", url: "fifthURL"))
        }
        testPokemonResults.append(PokemonEntry(name: "mockFavoritePokemon", url: "mockFavoritePokemon"))
        
        return Pokemon(results: testPokemonResults) as! T
    }
    
    func downloadImage(url: String) -> UIImage? {
        
        
        return nil
    }
}
