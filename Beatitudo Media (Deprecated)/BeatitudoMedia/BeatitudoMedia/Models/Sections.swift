//
//  Sections.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/12/24.
//

import Foundation

struct Sections: Codable {
    let sections: [Section]
}

extension Sections {
    func returnSortedSectionsWithSortedArticles() -> Sections {
        
        return Sections(sections: self.sections.map { $0.returnSectionWithSortedArticles() })
    }
}
