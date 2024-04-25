//
//  MemoryCacheManager.swift
//  PokeDex
//
//  Created by Jinho Lee on 4/25/24.
//

import Foundation

final class MemoryCacheManager: NSCache<AnyObject, AnyObject> {
    static let shared = MemoryCacheManager()
    
    private override init() { }
    
    
}
