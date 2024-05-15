//
//  BeatitudoMediaNetworkService.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/14/24.
//

import Foundation

class BeatitudoMediaNetworkService {
    private let domain: NetworkLayer
    
    private var sectionsTask: Task<Void, Error>?
    
    @Published var sections: [Section] = []
    
    init(domain: NetworkLayer = APIServices.shared) {
        self.domain = domain
        self.sectionsTask?.cancel()
        self.sectionsTask = Task {
            let fetchedSections: Sections = try await self.domain.fetchData(url: "http://172.30.1.17:8000/sections/send-sections/")
            await MainActor.run { self.sections = fetchedSections.sections }
        }
    }
}
