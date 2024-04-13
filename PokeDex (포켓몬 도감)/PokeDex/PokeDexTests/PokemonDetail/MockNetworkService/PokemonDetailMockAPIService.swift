//
//  PokemonDetailMockAPIService.swift
//  PokeDexTests
//
//  Created by Jinho Lee on 3/15/24.
//

import Foundation
import UIKit
@testable import PokeDex

final class PokemonDetailMockAPIService: NetworkLayer {
    static let shared = PokemonDetailMockAPIService()
    
    private init() { }
    
    func fetchData<T: Decodable>(url: String) async throws -> T {
        let testPokemonSelected: PokemonSelected = PokemonSelected(sprites: PokemonSprites(frontDefault: "", other: Other(officialArtwork: OfficialArtwork(frontDefault: ""))), types: [PokemonType(type: TypeElement(name: "mockType"))], abilities: [PokemonAbility(ability: Ability(name: "ability1")), PokemonAbility(ability: Ability(name: "ability2")), PokemonAbility(ability: Ability(name: "ability3")), PokemonAbility(ability: Ability(name: "ability4")), PokemonAbility(ability: Ability(name: "ability5"))], moves: [PokemonMove(move: Move(name: "move1")), PokemonMove(move: Move(name: "move2")), PokemonMove(move: Move(name: "move3")), PokemonMove(move: Move(name: "move4")), PokemonMove(move: Move(name: "move5"))])
        
        return testPokemonSelected as! T
    }
    
    func fetchBoundedData<T: Decodable>(offset: Int, limit: Int) -> T {
    
        return "" as! T
    }
    
    func downloadImage(url: String) -> UIImage? {
        
        
        return nil
    }
}
