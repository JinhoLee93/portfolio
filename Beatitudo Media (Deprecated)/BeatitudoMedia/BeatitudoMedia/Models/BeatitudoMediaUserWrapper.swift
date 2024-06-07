//
//  BeatitudoMediaUserWrapper.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/24/24.
//

import Foundation

// MARK: - Wrapper for BeatitudoMediaUser
struct BeatitudoMediaUserWrapper: Codable, Hashable {
    let beatitudoMediaUser: BeatitudoMediaUser
    
    enum CodingKeys: String, CodingKey {
        case beatitudoMediaUser = "beatitudo_media_user"
    }
}
