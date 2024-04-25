//
//  MemoryCacheManager.swift
//  PokeDex
//
//  Created by Jinho Lee on 4/25/24.
//

import Foundation
import SwiftUI
import Combine

final class MemoryCacheManager {
    static let shared = MemoryCacheManager()
    
    private init() { }
    
    var imageCache: NSCache<NSString, UIImage> = {
        
        // Customize your cache
        let cache = NSCache<NSString, UIImage>()
        
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        
        return cache
    }() // Key-Value Dictionary-like Data Structure
    
    func addToCache(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
    }
    
    func removeFromCache(name: String) {
        imageCache.removeObject(forKey: name as NSString)
    }
    
    func getImage(name: String) -> UIImage? {
        
        return imageCache.object(forKey: name as NSString)
    }
}
