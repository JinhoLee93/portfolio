//
//  ImageCache.swift
//  PokeDex
//
//  Created by Jinho Lee on 3/4/24.
//

import Foundation
import UIKit
import SwiftUI
import Kingfisher

// MARK: - Turns GCD Based Kingfisher Functions into Swift Concurrency.
@available(iOS 13.0, *)
extension ImageCache {
    // Wrapper function to convert DispatchQueue to Swift Concurrency using Continuation.
    private func retrieveImageWithConcurrency(url: String) async -> UIImage? {
        return await withCheckedContinuation { continuation in
            self.retrieveImage(forKey: url) { result in
                switch result {
                case .success(let result):
                    continuation.resume(returning: result.image)
                case .failure(let error):
                    print("kf: error: \(error) occurred retrieving image")
                    continuation.resume(returning: nil)
                }
            }
        }
    }

    // Get the requested image from cache.
    // 1. Check if the image is in cache
    // 2. Get it from cache if it exists in cache. Otherwise, fetch it from the server.
    func retrieveImageWithConcurrency(domain: NetworkLayer, pokemonEntry: PokemonEntry) async throws -> UIImage? {
        if self.isCached(forKey: pokemonEntry.url) {
            if let pokemonImage = await self.retrieveImageWithConcurrency(url: pokemonEntry.url) {
                
                return pokemonImage
            }
        } else {
            let pokemonSelected: PokemonSelected = try await domain.fetchData(url: pokemonEntry.url)
            let pokemonOfficialArtwork = pokemonSelected.sprites.other.officialArtwork
            let pokemonImage: UIImage? = try await domain.downloadImage(url: pokemonOfficialArtwork.frontDefault ?? "")
            if let pokemonImage = pokemonImage {
                self.store(pokemonImage, forKey: pokemonEntry.url)

                return pokemonImage
            }
        }
        
        return nil
    }
}
