//
//  ListViewCell.swift
//  PokeDex
//
//  Created by Jinho Lee on 2/12/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import SnapKit
import Kingfisher

// MARK: - Shows Pokemon Images and Names
class PokeDexListViewCell: UITableViewCell {
    static let identifier = "PokeDexListViewCell"
    private let errorIdentifier = "PokeDexListViewCell"
    private let disposeBag = DisposeBag()
    private let domain = APIServices.shared
    
    var outsideDisposeBag = DisposeBag()
    
    // Cancel Network Request
    private var imageTask: Task<Void, Error>?
    
    private let pokemonStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 20
        
        return sv
    }()
    
    private let pokemonImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Loading")!
        
        return iv
    }()
    
    private let pokemonName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let isFavoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)

        return button
    }()
    
    let pokemon: AnyObserver<ViewPokemon>
    let onFavoriteChanged: Observable<Void>
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let preparePokemon = PublishSubject<ViewPokemon>()
        let prepareName = BehaviorSubject<String>(value: "")
        let prepareURL = PublishSubject<ViewPokemon>()
        let prepareImage = PublishSubject<UIImage>()
        let prepareIsFavoriteButton = PublishSubject<Bool>()
        let prepareOnFavoriteChanged = PublishSubject<Void>()
        
        pokemon = preparePokemon.asObserver()
        
        onFavoriteChanged = prepareOnFavoriteChanged
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
        
        preparePokemon
            .subscribe(onNext: { viewPokemon in
                prepareURL.onNext(viewPokemon)
                prepareName.onNext(viewPokemon.name)
                prepareIsFavoriteButton.onNext(viewPokemon.isFavorite)
            })
            .disposed(by: disposeBag)
        
        prepareURL
            .subscribe(onNext: { [weak self] viewPokemon in
                guard let self = self else { return }
                self.imageTask = Task {
                    if let pokemonImage =
                        await self.fetchPokemonImage(domain: self.domain, pokemonEntry: viewPokemon.asPokemonEntry())
                    {
                        prepareImage.onNext(pokemonImage)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        prepareImage
            .asDriver(onErrorJustReturn: UIImage(named: "Loading")!)
            .drive(pokemonImageView.rx.image)
            .disposed(by: disposeBag)
            
        prepareName
            .map { $0.localizedCapitalized }
            .asDriver(onErrorJustReturn: "")
            .drive(pokemonName.rx.text)
            .disposed(by: disposeBag)
        
        prepareIsFavoriteButton
            .map { UIImage(systemName: $0 ? "star.fill" : "star")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal) }
            .subscribe(onNext: { [weak self] image in
                self?.isFavoriteButton.setImage(image, for: .normal)
            })
            .disposed(by: disposeBag)
        
//        Observable.zip(prepareName, prepareURL)
//            .map { pokemonName, viewPokemon -> Bool in
//                if let viewPokemon = viewPokemon {
//                    let favoritePokemons = FavoritePokemonsCoreDataViewModel.shared.getFavoritePokemons()
//                    
//                    return favoritePokemons.contains(where: { $0.name == pokemonName && $0.url == viewPokemon.url })
//                }
//                
//                return false
//            }
//            .map { UIImage(systemName: $0 ? "star.fill" : "star")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal) }
//            .subscribe(onNext: { [weak self] image in
//                self?.isFavoriteButton.setImage(image, for: .normal)
//            })
//            .disposed(by: disposeBag)
        
        isFavoriteButton.rx.tap
            .subscribe(onNext: prepareOnFavoriteChanged.onNext)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        outsideDisposeBag = DisposeBag()
        pokemonImageView.image = UIImage(named: "Loading")!
    }
}

extension PokeDexListViewCell {
    private func setUpUI() {
        self.selectionStyle = .none
        contentView.addSubview(pokemonStack)
        pokemonStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(50)
        }
    
        pokemonStack.addArrangedSubview(pokemonImageView)
        pokemonImageView.snp.makeConstraints {
            $0.width.height.equalTo(75)
        }
        
        pokemonStack.addArrangedSubview(pokemonName)
        contentView.addSubview(isFavoriteButton)
        isFavoriteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview()
        }
    }
    
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
}
