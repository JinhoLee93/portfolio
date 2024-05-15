//
//  BeatitudoMediaViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/7/24.
//

import Foundation
import Combine

class BeatitudoMediaViewModel: ObservableObject {
    @Published var sections: [Section] = []
    
    private var anyCancellables = Set<AnyCancellable>()
    
    private let domain: BeatitudoMediaNetworkService
    
    init(domain: NetworkLayer = APIServices.shared) {
        self.domain = BeatitudoMediaNetworkService(domain: domain)
        self.addSubscribers()
    }
    
    func tokenizeURLandReturnName(_ string: String) -> String {
        let tokens = string.split(separator: ".").map { String($0) }
        
        return tokens.count < 1 ? "" : tokens[1]
    }
    
    
    // Subscribers
    func addSubscribers() {
        self.domain.$sections
            .handleEvents(receiveRequest:  { _ in
                // show loading
            })
            .sink { [weak self] in
                self?.sections = $0
                // hide loading
            }
            .store(in: &anyCancellables)
    }
}

// Helpers
extension BeatitudoMediaViewModel {
    func getSectionIndex(of section: Section) -> Int {
        
        return self.sections.firstIndex { $0.title == section.title } ?? 0
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
