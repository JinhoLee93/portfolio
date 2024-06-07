//
//  NetworkReacheabilityManager.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/23/24.
//

import Foundation
import Network

final class NetworkReacheabilityManager {
    static let shared = NetworkReacheabilityManager()
    
    private init() { }
    
    let monitor = NWPathMonitor()
    
}
