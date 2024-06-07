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
