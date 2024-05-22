//
//  BeatitudoMediaLogInViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/22/24.
//

import Foundation

class BeatitudoMediaLogInViewModel: ObservableObject {
    @Published private var logInMethods = ["Google", "Email"]
    
    func getLogInMethods() -> [String] {
        
        return logInMethods
    }
    
    func getLogInMethodsCount() -> Int {
        
        return logInMethods.count
    }
}
