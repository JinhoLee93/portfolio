//
//  IndividualSectionAPIServices.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 6/6/24.
//

import Foundation

class IndividualSectionAPIServices: ObservableObject {
    private let domain: NetworkLayer
    
    @Published var individualSection: Section?
    
    init(domain: NetworkLayer = APIServices.shared) {
        self.domain = domain
    }
}

// MARK: - API
extension IndividualSectionAPIServices {
    func fetchIndividualSection(sectionId: Int) async throws {
        let url = "http://\(GlobalAssets.serverIp)/beatitudo-media-sections/send-sections/"
        let parameters: [String : Any] = ["section_id" : sectionId]
        let fetchedSection: Section = try await domain.post(url: url, parameters: parameters)
        
        await MainActor.run { self.individualSection = fetchedSection.returnSectionWithSortedArticles() }
    }
}
