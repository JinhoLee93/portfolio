//
//  PokemonDetailViewModel.swift
//  PokeDex
//
//  Created by Jinho Lee on 2/23/24.
//

import Foundation
import UIKit
import RxSwift
import Kingfisher

protocol PokemonDetailViewModelType {
    // Inputs from VC
    var pokemon: AnyObserver<ViewPokemon> { get }
    
    // Outputs to VC
    var isLoadingViewHidden: Observable<Bool> { get }
    var pokemonImage: Observable<UIImage> { get }
    var pokemonName: Observable<String> { get }
    var pokemonType: Observable<String> { get }
    var pokemonAbilities: Observable<[PokemonAbility]> { get }
    var pokemonMoves: Observable<[PokemonMove]> { get }
    var pokemonDetailSections: Observable<[PokemonDetailSection]> { get }
}

class PokemonDetailViewModel: PokemonDetailViewModelType {
    private let disposeBag = DisposeBag()
    private let errorIdentifier = "PokemonDetailViewModel"
    
    private var task: Task<Void, Error>? = nil
    
    let isLoadingViewHidden: Observable<Bool>
    
    let pokemon: AnyObserver<ViewPokemon>
    
    let pokemonImage: Observable<UIImage>
    let pokemonName: Observable<String>
    let pokemonType: Observable<String>
    let pokemonAbilities: Observable<[PokemonAbility]>
    let pokemonMoves: Observable<[PokemonMove]>
    let pokemonDetailSections: Observable<[PokemonDetailSection]>
    
    init(domain: NetworkLayer = APIServices.shared, viewPokemon: ViewPokemon) {
        let prepareIsLoadingViewHidden = PublishSubject<Bool>()
        let prepareViewPokemon = BehaviorSubject<ViewPokemon>(value: ViewPokemon(name: "", url: "", isFavorite: false))
        let preparePokemonImage = BehaviorSubject<UIImage>(value: UIImage(named: "Loading")!)
        let preparePokemonName = BehaviorSubject<String>(value: "")
        let preparePokemonType = BehaviorSubject<String>(value: "unknown")
        let preparePokemonAbilities = BehaviorSubject<[PokemonAbility]>(value: [])
        let preparePokemonMoves = BehaviorSubject<[PokemonMove]>(value: [])
        let preparePokemonDetailSections = PublishSubject<[PokemonDetailSection]>()
        
        isLoadingViewHidden = prepareIsLoadingViewHidden
        
        pokemonImage = preparePokemonImage
        
        pokemonName = preparePokemonName
        
        pokemonType = preparePokemonType
        
        pokemonAbilities = preparePokemonAbilities
        
        pokemonMoves = preparePokemonMoves
        
        pokemonDetailSections = preparePokemonDetailSections
        
        pokemon = prepareViewPokemon.asObserver()
        pokemon.onNext(viewPokemon)
        prepareViewPokemon
            .do(onNext: { _ in prepareIsLoadingViewHidden.onNext(false) })
            .subscribe(onNext: { [weak self] viewPokemon in
                guard let self = self else { return }
                self.task?.cancel()
                self.task = Task {
                    if let pokemonImage = 
                        await self.fetchPokemonImage(domain: domain, pokemonEntry: viewPokemon.asPokemonEntry())
                    {
                        preparePokemonImage.onNext(pokemonImage)
                    }
                    if let pokemonSelected = await self.fetchPokemonSelected(domain: domain, viewPokemon: viewPokemon) {
                        preparePokemonType.onNext(pokemonSelected.types[0].type.name)
                        preparePokemonAbilities.onNext(pokemonSelected.abilities)
                        preparePokemonMoves.onNext(pokemonSelected.moves)
                    }
                }
                preparePokemonName.onNext(viewPokemon.name)
            })
            .disposed(by: disposeBag)
        
        Observable.zip(preparePokemonAbilities, preparePokemonMoves) { abilities, moves in
            [PokemonDetailSection(header: "Pokemon Abilities", items: abilities.map { $0.ability.name }),
             PokemonDetailSection(header: "Pokemon Moves", items: moves.map { $0.move.name })]
        }
            .subscribe(onNext: preparePokemonDetailSections.onNext)
            .disposed(by: disposeBag)
        
        Observable.zip(preparePokemonType, preparePokemonDetailSections)
            .subscribe(onNext: { _, _ in prepareIsLoadingViewHidden.onNext(true) })
            .disposed(by: disposeBag)
    }
}

extension PokemonDetailViewModel {
    private func fetchPokemonImage(domain: NetworkLayer, pokemonEntry: PokemonEntry) async -> UIImage? {
        do {
            if let pokemonImage = try await ImageCache.default.retrieveImageWithConcurrency(domain: domain, pokemonEntry: pokemonEntry) {
                
                return pokemonImage
            }
        } catch let error {
            print("Error: \(error.localizedDescription) occurred while executing fetchPokemonImage for \(errorIdentifier).")
        }
        
        return nil
    }
    
    private func fetchPokemonSelected(domain: NetworkLayer, viewPokemon: ViewPokemon) async -> PokemonSelected? {
        do {
            if let pokemonSelected: PokemonSelected = try await domain.fetchData(url: viewPokemon.url) {
                
                return pokemonSelected
            }
        } catch let error {
            print("Error: \(error.localizedDescription) occurred while executing fetchPokemonSelected for \(errorIdentifier).")
        }
        
        return nil
    }
}
