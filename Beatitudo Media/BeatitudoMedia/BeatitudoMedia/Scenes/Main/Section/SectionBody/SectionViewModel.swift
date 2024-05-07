//
//  SectionViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/7/24.
//

import Foundation

class SectionViewModel: ObservableObject {
    let sections: [Section]
    
    init(sections: [Section]) {
        self.sections = sections
    }
    
    func getSectionIndex(of section: Section) -> Int {
        
        return sections.firstIndex { $0.title == section.title } ?? 0
    }
}
