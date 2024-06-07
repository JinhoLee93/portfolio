//
//  APIServices.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation
import SwiftUI
import Alamofire

protocol NetworkLayer {
    static var shared: Self { get }
    
    func get<T: Decodable>(url: String) async throws -> T
    
    func post<T: Decodable>(url: String, parameters: [String : Any]) async throws -> T
    
    func put<T: Decodable>(url: String, parameters: [String : Any]) async throws -> T
    
    func downloadImage(url: String) async throws -> Image?
}

final class APIServices: NetworkLayer {
    static var shared = APIServices()
    
    private var httpHeaders: HTTPHeaders = {
        var headers = HTTPHeaders()
        headers.add(name: "platform", value: "iOS")
        headers.add(name: "osVersion", value: Utils.getiOSVersion())
        
        return headers
    }()
    
    private init() { }
}

// MARK: - RESTful API
extension APIServices {
    func get<T: Decodable>(url: String) async throws -> T {
        let url = try convertStringToURL(url: url)
        
        var request = URLRequest(url: url)
        request.method = HTTPMethod.get
        request.headers = self.httpHeaders
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try handleHTTPURLResponse(response: response, url: url)
        
        return try decodeAndReturn(T.self, from: data)
    }
    
    func post<T: Decodable>(url: String, parameters: [String : Any]) async throws -> T {
        let url = try convertStringToURL(url: url)
        
        guard let jsonParameters = try? JSONSerialization.data(withJSONObject: parameters) else { throw URLError(.badURL)}
        
        var request = URLRequest(url: url)
        request.method = HTTPMethod.post
        request.headers = self.httpHeaders
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.upload(for: request, from: jsonParameters)
        
        try handleHTTPURLResponse(response: response, url: url)
        
        return try decodeAndReturn(T.self, from: data)
    }
    
    func put<T: Decodable>(url: String, parameters: [String : Any]) async throws -> T {
        let url = try convertStringToURL(url: url)
        
        guard let jsonParameters = try? JSONSerialization.data(withJSONObject: parameters) else { throw URLError(.unknown) }
        
        var request = URLRequest(url: url)
        request.method = HTTPMethod.put
        request.headers = self.httpHeaders
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.upload(for: request, from: jsonParameters)
        
        try handleHTTPURLResponse(response: response, url: url)
        
        return try decodeAndReturn(T.self, from: data)
    }
    
    func updateViews(id: Int, userUUID: String?) {
        let url = "http://127.0.0.1:8000/beatitudo-media-sections/update-article-views/\(id)/"
        
        AF.request(url, method: .put, parameters: nil, encoding: URLEncoding.default, headers: self.httpHeaders, interceptor: nil, requestModifier: nil).response { response in debugPrint(response) }
    }
}

// MARK: - Local
extension APIServices {
    func downloadImage(url: String) async throws -> Image? {
        if let uiImage = LocalCacheManager.shared.getImage(name: url) {
            
            return Image(uiImage: uiImage)
        } else {
            if let image = LocalFileManager.shared.getImage(imageName: url, folderName: "thumbnails") {
                
                return image
            }
        }
        
        let urlString = url
        let url = try convertStringToURL(url: url)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try handleHTTPURLResponse(response: response, url: url)
        
        guard let uiImage = UIImage(data: data) else { return nil }
        
        LocalCacheManager.shared.addToCache(uiImage: uiImage, name: urlString)
        LocalFileManager.shared.saveImage(image: uiImage, imageName: urlString, folderName: "thumbnails")
        
        return Image(uiImage: uiImage)
    }
    
    func convertStringToURL(url: String) throws -> URL {
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
        
        return try decoder.decode(T.self, from: data)
    }
}

enum NetworkingError: Error {
    case invalidURL(url: String)
    case invalidHTTPURLResponse(url: URL)
    case invalidHTTPURLResponseStatusCode(statusCode: Int)
    case invalidData
    case failedToSerializeAsJSON
}
