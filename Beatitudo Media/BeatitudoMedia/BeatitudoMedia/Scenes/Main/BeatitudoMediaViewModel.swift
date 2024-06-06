//
//  BeatitudoMediaViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/7/24.
//

import Foundation
import Combine
import UIKit

@MainActor
class BeatitudoMediaViewModel: ObservableObject {
    @Published var sections: [Section]         = []
    @Published var scrollProxyOffsetY: CGFloat = 0
    @Published var contentOffset: CGFloat      = 0
    @Published var progress: CGFloat           = 0
    @Published var isEligible: Bool            = false
    @Published var isRefreshing: Bool          = false
    @Published var gestureEndedToRefresh: Bool = false
    @Published var isInSectionView: Bool       = true
    
    private var anyCancellables = Set<AnyCancellable>()
    
    private let domain: BeatitudoMediaAPIServices
    
    init(domain: NetworkLayer = APIServices.shared) {
        self.domain = BeatitudoMediaAPIServices(domain: domain)
        self.addSubscribers()
    }
}

// MARK: - Helpers
extension BeatitudoMediaViewModel {
    func tokenizeURLandReturnName(_ string: String) -> String {
        let tokens = string.split(separator: ".").map { String($0) }
        
        return tokens.count < 1 ? "" : tokens[1]
    }
    
    func getSectionIndex(of section: Section) -> Int {
        
        return self.sections.firstIndex { $0.title == section.title } ?? 0
    }
    
    func refreshSections() async throws {
        try await self.domain.refreshSections()
    }
    
    func fetchCurrentUser() async throws {
        try await self.domain.fetchCurrentUser()
    }
    
    func translateSectionTitle(_ title: String) -> String {
        switch title {
        case "Moving":
            return "감동적이에요"
        case "Happy":
            return "행복해요"
        case "Amazing":
            return "놀라워요"
        case "Funny":
            return "웃겨요"
        default:
            return "SectionNameNotExpected"
        }
    }
}

// MARK: - Combine Related
extension BeatitudoMediaViewModel {
    // Subscribers
    private func addSubscribers() {
        self.domain.$sections
            .sink { [weak self] sections in
                self?.sections = sections
            }
            .store(in: &anyCancellables)
        
        self.domain.$currentUser
            .sink {
                GlobalAssets.currentUser = $0
            }
            .store(in: &anyCancellables)
    }
}
