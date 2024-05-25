//
//  BeatitudoMediaNetworkService.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/14/24.
//

import Foundation

class BeatitudoMediaNetworkService {
    private let domain: NetworkLayer
    
    @Published var sections: [Section] = []
    
    init(domain: NetworkLayer = APIServices.shared) {
        self.domain = domain
    }
    
    func refreshSections() async throws {
        let url = "http://\(GlobalAssets.serverIP)/sections/send-sections/"
        let fetchedSections: Sections = try await domain.get(url: url)
        await MainActor.run { self.sections = fetchedSections.sections }
    }
}
