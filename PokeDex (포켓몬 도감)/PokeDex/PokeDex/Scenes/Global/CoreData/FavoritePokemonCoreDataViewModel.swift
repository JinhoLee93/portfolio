//
//  FavoritePokemonCoreDataViewModel.swift
//  PokeDex
//
//  Created by Jinho Lee on 4/24/24.
//

import Foundation
import CoreData

class FavoritePokemonCoreDataViewModel: ObservableObject {
    
    let coreDataContainer: NSPersistentContainer
    
    init() {
        coreDataContainer = NSPersistentContainer(name: "FavoritePokemonCoreDataModel")
        coreDataContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Error Loading Core Data Model. \(error)")
            } else {
                print("Successfully Loaded Core Data Model.")
            }
        }
    }
}
