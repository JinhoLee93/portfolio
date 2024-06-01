//
//  IndividualSectionViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/31/24.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class IndividualSectionViewModel: ObservableObject {
    private let domain = IndividualSectionAPIServices()
    private var anyCancellables = Set<AnyCancellable>()
    
    @Published var individualSection: Section
    
    init(individualSection: Section) {
        self.individualSection = individualSection
        addSubscribers()
    }
}

// MARK: - Combine
extension IndividualSectionViewModel {
    func addSubscribers() {
        domain.$individualSection
            .sink { [weak self] in
                if let individualSection = $0 {
                    self?.individualSection = individualSection
                }
            }
            .store(in: &anyCancellables)
    }
}

// MARK: - API
extension IndividualSectionViewModel {
    func fetchIndividualSection() async throws {
        try await domain.fetchIndividualSection(sectionId: individualSection.id)
    }
}

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
        let url = "http://\(GlobalAssets.serverIP)/sections/send-sections/"
        let parameters: [String : Any] = ["section_id" : sectionId]
        let fetchedSection: Section = try await domain.post(url: url, parameters: parameters)
        await MainActor.run { self.individualSection = fetchedSection }
    }
}

