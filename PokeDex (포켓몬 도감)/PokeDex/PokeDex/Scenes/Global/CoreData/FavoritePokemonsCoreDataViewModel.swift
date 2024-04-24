//
//  FavoritePokemonsCoreDataViewModel.swift
//  PokeDex
//
//  Created by Jinho Lee on 4/24/24.
//

import SwiftUI
import CoreData
import RxSwift

final class FavoritePokemonsCoreDataViewModel {
    static let shared = FavoritePokemonsCoreDataViewModel()
    private let errorIdentifier = "FavoritePokemonsCoreDataViewModel"
    
    private let coreDataContainer: NSPersistentContainer
    
    private var savedEntities: [FavoritePokemonEntity] = []
    
    private init() {
        coreDataContainer = NSPersistentContainer(name: "FavoritePokemonCoreDataContainer")
        coreDataContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Error \(error.localizedDescription) occurred while loading coreDataContainer for \(self.errorIdentifier)")
            }
        }
        
        FetchFavoritePokemons()
    }
    
    func FetchFavoritePokemons() {
        let request: NSFetchRequest<FavoritePokemonEntity> = createFetchRequest(entityName: "FavoritePokemonEntity")
        
        do {
            let requestResult = try coreDataContainer.viewContext.fetch(request)
            savedEntities = requestResult
        } catch let error {
            print("Error \(error.localizedDescription) occurred while fetching requested result for \(errorIdentifier)")
        }
    }
    
    func addFavoritePokemon(_ pokemon: ViewPokemon) {
        let newFavoritePokemon = FavoritePokemonEntity(context: coreDataContainer.viewContext)
        newFavoritePokemon.name = pokemon.name
        newFavoritePokemon.url = pokemon.url
        saveData()
    }
    
    func removePokemonFromFavoriteList(_ pokemon: ViewPokemon) {
        if let pokemonIndex = savedEntities.firstIndex(where: { $0.name == pokemon.name && $0.url == pokemon.url }) {
            coreDataContainer.viewContext.delete(savedEntities[pokemonIndex])
            saveData()
        }
    }
    
    func deleteAllFavoritePokemons() {
        savedEntities.forEach {
            coreDataContainer.viewContext.delete($0)
        }
        saveData()
    }
    
    func getFavoritePokemons() -> [FavoritePokemonEntity] {
        
        return savedEntities
    }
    
    private func saveData() {
        do {
            try coreDataContainer.viewContext.save()
            FetchFavoritePokemons()
        } catch let error {
            print("Error \(error.localizedDescription) occurred while saving data for \(errorIdentifier)")
        }
    }
    
    private func createFetchRequest<T: NSManagedObject>(entityName: String) -> NSFetchRequest<T>{
        
        return NSFetchRequest<T>(entityName: entityName)
    }
}
