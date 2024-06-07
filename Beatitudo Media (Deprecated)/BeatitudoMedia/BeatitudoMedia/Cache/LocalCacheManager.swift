//
//  LocalCacheManager.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/8/24.
//

import Foundation
import SwiftUI

class LocalCacheManager {
    static var shared = LocalCacheManager()
    
    private init() { }
    
    private var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        
        return cache
    }()
    
    func addToCache(uiImage: UIImage, name: String) {
        imageCache.setObject(uiImage, forKey: name as NSString)
    }
    
    func removeFromCache(name: String) {
        imageCache.removeObject(forKey: name as NSString)
    }
    
    func getImage(name: String) -> UIImage? {
        
        return imageCache.object(forKey: name as NSString)
    }
}
