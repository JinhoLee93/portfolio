//
//  ListViewModel.swift
//  PokeDex
//
//  Created by Jinho Lee on 2/12/24.
//

import Foundation
import RxSwift
import RxRelay

protocol PokeDexListViewModelType {
    // Inputs from VC
    var callFetchPokemons: AnyObserver<Void> { get }
    var findPokemonQuery: AnyObserver<String> { get }
    var getPokemonAtIndex: AnyObserver<IndexPath> { get }
    var changeFavorite: AnyObserver<ViewPokemon> { get }
    var getFavoritePokemonsReady: AnyObserver<Void> { get }
    
    // Outputs to VC
    var pokemons: Observable<[ViewPokemon]> { get }
    var pokemonAtIndex: Observable<ViewPokemon> { get }
    var getFavoritePokemons: Observable<[ViewPokemon]> { get }
}

class PokeDexListViewModel: PokeDexListViewModelType {
    private let disposeBag = DisposeBag()
    private let errorIdentifier = "PokeDexListViewModel"
    
    private var fetchTask: Task<Void, Error>? = nil
    
    let callFetchPokemons: AnyObserver<Void>
    let findPokemonQuery: AnyObserver<String>
    let getPokemonAtIndex: AnyObserver<IndexPath>
    let changeFavorite: AnyObserver<ViewPokemon>
    let getFavoritePokemonsReady: AnyObserver<Void>
    
    let pokemons: Observable<[ViewPokemon]>
    let pokemonAtIndex: Observable<ViewPokemon>
    let getFavoritePokemons: Observable<[ViewPokemon]>
    
    init(domain: NetworkLayer = APIServices.shared) {
        let originalPokemons = BehaviorRelay<Pokemon>(value: Pokemon(results: []))
        let favoritePokemons = BehaviorRelay<[ViewPokemon]>(value: convertEntityToViewPokemon(FavoritePokemonsCoreDataViewModel.shared.getFavoritePokemons()))
        let preparePokemons = BehaviorSubject<[ViewPokemon]>(value: [])
        let prepareFetchPokemons = PublishSubject<Void>()
        let prepareFindPokemonQuery = BehaviorSubject<String>(value: "")
        let prepareGetPokemonAtIndex = PublishSubject<IndexPath>()
        let preparePokemonAtIndex = BehaviorSubject<ViewPokemon>(value: ViewPokemon(name: "", url: "", isFavorite: false))
        let prepareChangeFavorite = PublishSubject<ViewPokemon>()
        let prepareGetFavoritePokemonsReady = PublishSubject<Void>()
        let prepareGetFavoritePokemons = BehaviorSubject<[ViewPokemon]>(value: [])
        
        pokemons = preparePokemons
        
        // Filter Pokemons
        findPokemonQuery = prepareFindPokemonQuery.asObserver()
        prepareFindPokemonQuery
            .distinctUntilChanged()
            .map { (originalPokemons.value, $0)}
            .map { originalPokemons, query in
                if query.count > 0 {
                    
                    return originalPokemons.results.filter { $0.name.contains(query.lowercased()) }
                }
                
                return originalPokemons.results
            }
            .map { filteredPokemons in
                let currentFavoritePokemons = favoritePokemons.value
                
                return filteredPokemons.map { filteredPokemon in
                        if currentFavoritePokemons.contains(where: { $0.name == filteredPokemon.name })
                        {
                            filteredPokemon.asViewPokemon(isFavorite: true)
                        } else {
                            filteredPokemon.asViewPokemon()
                        }
                    }
            }
            .subscribe(onNext: preparePokemons.onNext)
            .disposed(by: disposeBag)
        
        // Select Pokemon
        getPokemonAtIndex = prepareGetPokemonAtIndex.asObserver()
        prepareGetPokemonAtIndex
            .map { $0.row }
            .withLatestFrom(preparePokemons) { index, filteredPokemons in
                filteredPokemons[index]
            }
            .subscribe(onNext: preparePokemonAtIndex.onNext)
            .disposed(by: disposeBag)
        
        pokemonAtIndex = preparePokemonAtIndex
        
        // Change the Favorite status of selected Pokemons
        changeFavorite = prepareChangeFavorite.asObserver()
        prepareChangeFavorite
            .withLatestFrom(pokemons) { pokemonToBeChanged, currentPokemons in
                currentPokemons.map { currentPokemon in
                    if currentPokemon.name == pokemonToBeChanged.name {
                        if favoritePokemons.value.contains(where: { $0.name == currentPokemon.name && $0.url == currentPokemon.url }) {
                            FavoritePokemonsCoreDataViewModel.shared.removePokemonFromFavoriteList(pokemonToBeChanged)
                        } else {
                            FavoritePokemonsCoreDataViewModel.shared.addFavoritePokemon(currentPokemon)
                        }
                        favoritePokemons.accept(convertEntityToViewPokemon(FavoritePokemonsCoreDataViewModel.shared.getFavoritePokemons()))

                        return currentPokemon.changeIsFavorite(isFavorite: !currentPokemon.isFavorite)
                    }
                    
                    return currentPokemon
                }
            }
            .subscribe(onNext: preparePokemons.onNext)
            .disposed(by: disposeBag)
        
        // Get Favorite Pokemons
        getFavoritePokemons = prepareGetFavoritePokemons
        getFavoritePokemonsReady = prepareGetFavoritePokemonsReady.asObserver()
        prepareGetFavoritePokemonsReady
            .withLatestFrom(favoritePokemons) { $1 }
            .subscribe(onNext: prepareGetFavoritePokemons.onNext)
            .disposed(by: disposeBag)
        
        // Fetch Pokemons
        callFetchPokemons = prepareFetchPokemons.asObserver()
        prepareFetchPokemons
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.fetchTask?.cancel()
                self.fetchTask = Task {
                    let nxtPokemons = originalPokemons.value
                    if let fetchedPokemon = await self.fetchPokemons(domain: domain, offset: nxtPokemons.getOffset())
                    {
                        let currentFavoritPokemons = favoritePokemons.value
                        originalPokemons.accept(nxtPokemons.appendNewPokemon(fetchedPokemon))
                        preparePokemons.onNext(originalPokemons.value.results.map { pokemon in
                            if currentFavoritPokemons.contains(where: { $0.name == pokemon.name }) {
                                pokemon.asViewPokemon(isFavorite: true)
                            } else {
                                pokemon.asViewPokemon()
                            }
                        })
                    }
                }
            })
            .disposed(by: disposeBag)
        
        func convertEntityToViewPokemon(_ entities: [FavoritePokemonEntity]) -> [ViewPokemon] {
            var favoriteViewPokemons: [ViewPokemon] = []
            FavoritePokemonsCoreDataViewModel.shared.getFavoritePokemons().forEach { entity in
                if let entityName = entity.name, let entityURL = entity.url {
                    favoriteViewPokemons.append(ViewPokemon(name: entityName, url: entityURL, isFavorite: true))
                }
            }
            
            return favoriteViewPokemons
        }
    }
}

extension PokeDexListViewModel {
    private func fetchPokemons(domain: NetworkLayer, offset: Int, limit: Int = 20) async -> Pokemon? {
        do {
            if let fetchedPokemon: Pokemon = try await domain.fetchBoundedData(offset: offset, limit: limit) {
                
                return fetchedPokemon
            }
        } catch let error {
            print("Error: \(error.localizedDescription) occurred while executing fetchPokemons for \(errorIdentifier).")
        }
        
        return nil
    }
}
