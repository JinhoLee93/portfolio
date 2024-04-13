//
//  APIServices.swift
//  PokeDex
//
//  Created by Jinho Lee on 2/15/24.
//

import Foundation
import UIKit
import RxSwift
import Kingfisher

// MARK: - API Service Begins Here
protocol NetworkLayer {
    static var shared: Self { get }
    
    func fetchData<T: Decodable>(url: String) async throws -> T
    
    func fetchBoundedData<T: Decodable>(offset: Int, limit: Int) async throws -> T
    
    func downloadImage(url: String) async throws -> UIImage?
}

final class APIServices: NetworkLayer {
    static let shared = APIServices()
    
    private init() { }
    
    private let constants = APIConstants()
    
    func fetchData<T: Decodable>(url: String) async throws -> T {
        let url = try convertStringToURL(url: url)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try handleHTTPURLResponse(response: response, url: url)
        
        return try decodeAndReturn(T.self, from: data)
    }
    
    func fetchBoundedData<T: Decodable>(offset: Int, limit: Int = 20) async throws -> T {
        /* Scroll to Fetch Limit capped to 20 by default */
        let tokens = constants.createFetchRequest(offset: offset, limit: limit)
        
        let url = try convertStringToURL(url: tokens)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try handleHTTPURLResponse(response: response, url: url)
        
        return try decodeAndReturn(T.self, from: data)
    }
    
    func downloadImage(url: String) async throws -> UIImage? {
        let url = try convertStringToURL(url: url)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try handleHTTPURLResponse(response: response, url: url)
        
        return UIImage(data: data)
    }
    
    private func convertStringToURL(url: String) throws -> URL {
        guard let url = URL(string: url) else {
            throw PokemonFetchError.invalidURL(url: url)
        }
        
        return url
    }
    
    private func handleHTTPURLResponse(response: URLResponse, url: URL) throws {
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw PokemonFetchError.invalidHTTPURLResponse(url: url)
        }
    }
    
    private func decodeAndReturn<T: Decodable>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(T.self, from: data)
        } catch {
            throw PokemonFetchError.invalidData
        }
    }
}

enum PokemonFetchError: Error {
    case invalidURL(url: String)
    case invalidHTTPURLResponse(url: URL)
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .invalidURL(url: let url): 
            return NSLocalizedString("Invalid URL: \(url).", comment: "PokemonFetchError.invalidURL")
        case .invalidHTTPURLResponse(url: let url): 
            return NSLocalizedString("Invalid HTTP Response from URL: \(url).",
                                     comment: "PokemonFetchError.invalidHTTPURLResponse")
        case .invalidData:
            return NSLocalizedString("Invalid Data.", comment: "PokemonFetchError.invalidData")
        }
    }
}
