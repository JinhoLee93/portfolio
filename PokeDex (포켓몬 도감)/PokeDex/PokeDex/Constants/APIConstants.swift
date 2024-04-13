//
//  Constants.swift
//  PokeDex
//
//  Created by Jinho Lee on 3/7/24.
//

import Foundation

// MARK: - API Requst Token Related
struct APIConstants {
    // API Tokens
    private let baseAPIToken = "https://pokeapi.co/api/v2/"

    // Creates API requests
    func createFetchRequest(offset: Int, limit: Int) -> String {

        return baseAPIToken + "pokemon?offset=\(offset)&limit=\(limit)"
    }
    
    // Fetch all pokemon in database.
    func createFetchAllRequest() -> String {
        return createFetchRequest(offset: 0, limit: 10000)
    }
}
