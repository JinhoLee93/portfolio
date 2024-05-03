//
//  APIServices.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation
import SwiftUI

protocol NetworkLayer {
    static var shared: Self { get }
    
    func fetchData<T: Decodable>(url: String) async throws -> T
    
    func downloadImage(url: String) async throws -> Image?
}

final class APIServices: NetworkLayer {
    static var shared = APIServices()
    
    private init() { }
    
    func fetchData<T>(url: String) async throws -> T where T : Decodable {
        let url = try convertStringToURL(url: url)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try handleHTTPURLResponse(response: response, url: url)
        
        return try decodeAndReturn(T.self, from: data)
    }
    
    func downloadImage(url: String) async throws -> Image? {
        let url = try convertStringToURL(url: url)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try handleHTTPURLResponse(response: response, url: url)
        
        if let uiImage = UIImage(data: data) {
            
            return Image(uiImage: uiImage)
        }
        
        return nil
    }
    
    private func convertStringToURL(url: String) throws -> URL {
        guard let url = URL(string: url) else {
            throw NetworkingError.invalidURL(url: url)
        }

        return url
    }
    
    private func handleHTTPURLResponse(response: URLResponse, url: URL) throws {
        guard let response = response as? HTTPURLResponse else {
            throw NetworkingError.invalidHTTPURLResponse(url: url)
        }
        
        if !(200 <= response.statusCode && response.statusCode < 300) {
            throw NetworkingError.invalidHTTPURLResponseStatusCode(statusCode: response.statusCode)
        }
    }
    
    private func decodeAndReturn<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(T.self, from: data)
    }
}

enum NetworkingError: Error {
    case invalidURL(url: String)
    case invalidHTTPURLResponse(url: URL)
    case invalidHTTPURLResponseStatusCode(statusCode: Int)
    case invalidData
}
