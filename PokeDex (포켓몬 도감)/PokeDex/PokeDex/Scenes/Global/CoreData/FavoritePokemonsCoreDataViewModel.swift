//
//  FavoritePokemonsCoreDataViewModel.swift
//  PokeDex
//
//  Created by Jinho Lee on 4/24/24.
//

import SwiftUI
import CoreData
import RxSwift

protocol ViewModel {
    
}

class FavoritePokemonsCoreDataViewModel: ObservableObject, ViewModel {
    
    let coreDataContainer: NSPersistentContainer
    @Published var savedEntities: [FavoritePokemonEntity] = []
    var savedEntitiesObservable = BehaviorSubject<[FavoritePokemonEntity]>(value: [])
    
    private var backUpEntities: [FavoritePokemonEntity]
    
    init() {
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
            var requestResult = try coreDataContainer.viewContext.fetch(request)
            
            // SwiftUI
            savedEntities = requestResult
            
            // UIKit
            savedEntitiesObservable.onNext(requestResult)
            
            // Backup
            backUpEntities = requestResult
            
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
    
//    func removePokemonFromFavoriteList(_ pokemon: ViewPokemon) {
//        
//    }
    
    private func saveData() {
        do {
            try coreDataContainer.viewContext.save()
            FetchFavoritePokemons()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    func deleteAllDataFromContainer() {
        backUpEntities.forEach {
            coreDataContainer.viewContext.delete($0)
        }
    }
    
    private func createFetchRequest<T: NSManagedObject>(entityName: String) -> NSFetchRequest<T>{
        
        return NSFetchRequest<T>(entityName: entityName)
    }
}

var co = 0
struct FavoritePokemonCoreDataTest: View {
    @StateObject var vm = FavoritePokemonsCoreDataViewModel()
    @State var addText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(vm.savedEntities) { entity in
                        LazyVStack {
                            Text(entity.name!)
                        }
                    }
                }
                Button(action: {
                    var p = ViewPokemon(name: "\(co)", url: "", isFavorite: true)
                    co += 1
                    vm.addFavoritePokemon(p)
                }, label: { Text("Add") })
                Button(action: {
                    vm.deleteAllDataFromContainer()
                }, label: { Text("Delete all") })
            }
            .navigationTitle("pokemons")
        }
    }
}

#Preview {
    FavoritePokemonCoreDataTest()
}
