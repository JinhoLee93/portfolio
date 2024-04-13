//
//  FavoritePokemonsMockAPIService.swift
//  PokeDexTests
//
//  Created by Jinho Lee on 3/16/24.
//

import Foundation
import UIKit
@testable import PokeDex

final class FavoritePokemonsMockAPIService: NetworkLayer {
    static let shared = FavoritePokemonsMockAPIService()
    
    private init() { }
    
    func fetchData<T>(url: String) -> T where T : Decodable {
        let mockPokemonSelected: PokemonSelected = PokemonSelected(sprites: PokemonSprites(frontDefault: "", other: Other(officialArtwork: OfficialArtwork(frontDefault: ""))), types: [PokemonType(type: TypeElement(name: "mockType"))], abilities: [PokemonAbility(ability: Ability(name: "mockAbility"))], moves: [PokemonMove(move: Move(name: "mockMove"))])
        
        return mockPokemonSelected as! T
    }
    
    func fetchBoundedData<T>(offset: Int, limit: Int) -> T where T : Decodable {
        
        return "" as! T
    }
    
    func downloadImage(url: String) -> UIImage? {
        
        return nil
    }
    
    
}
