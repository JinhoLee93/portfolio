//
//  TableViewSection.swift
//  PokeDex
//
//  Created by Jinho Lee on 3/16/24.
//

import Foundation
import RxDataSources

// MARK: - RxDataSources Model
struct PokemonDetailSection {
    var header: String
    var items: [Item]
}

extension PokemonDetailSection: SectionModelType {
    typealias Item = String
    
    init(original: PokemonDetailSection, items: [String]) {
        self = original
        self.items = items
    }
}
