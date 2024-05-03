//
//  Article.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/2/24.
//

import Foundation

struct Article: Identifiable {
    let id = UUID()
    let title: String
    let thumbnailURL: String
    let articleMetadataURL: String
    let articleAuxiliaryDataURL: String
}
