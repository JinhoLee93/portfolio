//
//  FavoritePokemonsCoreDataViewModel.swift
//  PokeDex
//
//  Created by Jinho Lee on 4/24/24.
//

import SwiftUI
import CoreData
import RxSwift

final class FavoritePokemonsCoreDataViewModel: ObservableObject {
    static let shared = FavoritePokemonsCoreDataViewModel()
    
    private let coreDataContainer: NSPersistentContainer
    
    @Published private var savedEntities: [FavoritePokemonEntity] = []
    
    private init() {
        coreDataContainer = NSPersistentContainer(name: "FavoritePokemonCoreDataContainer")
        coreDataContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Error Loading Core Data Model. \(error)")
            } else {
                print("Successfully Loaded Core Data Model.")
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
            print("Error fetching. \(error)")
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
            print("Error saving. \(error)")
        }
    }
    
    private func createFetchRequest<T: NSManagedObject>(entityName: String) -> NSFetchRequest<T>{
        
        return NSFetchRequest<T>(entityName: entityName)
    }
}
//
//var co = 0
//struct FavoritePokemonCoreDataTest: View {
//    @StateObject var vm = FavoritePokemonsCoreDataViewModel.shared
//    @State var addText = ""
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    ForEach(vm.getFavoritePokemons()) { entity in
//                        LazyVStack {
//                            Text(entity.name!)
//                        }
//                    }
//                }
//                Button(action: {
//                    var p = ViewPokemon(name: "\(co)", url: "", isFavorite: true)
//                    co += 1
//                    vm.addFavoritePokemon(p)
//                }, label: { Text("Add") })
//                Button(action: {
//                    vm.deleteAllFavoritePokemons()
//                }, label: { Text("Delete all") })
//            }
//            .navigationTitle("pokemons")
//        }
//    }
//}
//
//#Preview {
//    FavoritePokemonCoreDataTest()
//}
