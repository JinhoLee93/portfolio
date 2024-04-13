//
//  ViewController.swift
//  PokeDex
//
//  Created by Jinho Lee on 2/12/24.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import SnapKit
import UIScrollView_InfiniteScroll

// MARK: - Main VC for PokeDex
class PokeDexListViewController: UIViewController, UIGestureRecognizerDelegate {
    private let viewModel: PokeDexListViewModelType
    private let disposeBag = DisposeBag()
    
    private let showFavoritePokemonButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star.fill")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal), for: .normal)
        
        return button
    }()
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.indicatorStyle = .white
        tv.infiniteScrollDirection = .vertical
        tv.register(PokeDexListViewCell.self, forCellReuseIdentifier: PokeDexListViewCell.identifier)
        tv.keyboardDismissMode = .onDrag
        
        return tv
    }()
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter a Pokemon..."
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.borderStyle = .roundedRect
    
        return tf
    }()
    
    init(viewModel: PokeDexListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Set Up UI
    private func setUpUI() {
        setUpNavigationItems()
        
        self.view.addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setUpNavigationItems() {
        let logo = UIImage(named: "Logo")!
        logoImageView.image = logo
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(logoTapped))
        logoImageView.isUserInteractionEnabled = true
        logoImageView.addGestureRecognizer(tapGestureRecognizer)
        
        navigationItem.titleView = logoImageView
        logoImageView.snp.makeConstraints {
            $0.width.equalTo(logo.size.width / 4)
            $0.height.equalTo(logo.size.height / 4)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: showFavoritePokemonButton)
    }
    
    
    // MARK: - Bind the ViewModel
    private func bindViewModel() {
        let viewDidLoad: Void = Void()
        viewModel.callFetchPokemons.onNext(viewDidLoad)
        
        viewModel.pokemons
            .bind(to: tableView.rx.items(cellIdentifier: PokeDexListViewCell.identifier, cellType: PokeDexListViewCell.self))
            { [weak self] row, item, cell in
                guard let self = self else { return }
                cell.separatorInset = UIEdgeInsets.zero
                cell.pokemon.onNext(item)
                cell.onFavoriteChanged
                    .map { item }
                    .bind(to: self.viewModel.changeFavorite)
                    .disposed(by: cell.outsideDisposeBag)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .do(onNext: viewModel.getPokemonAtIndex.onNext)
            .withLatestFrom(viewModel.pokemonAtIndex) { $1 }
            .subscribe(onNext: { [weak self] pokemonAtIndex in
                self?.textField.endEditing(true)
                let vm = PokemonDetailViewModel(viewPokemon: pokemonAtIndex)
                let vc = PokemonDetailViewController(viewModel: vm)
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)

        textField.rx.text.orEmpty
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .do(onNext: { [weak self] text in
                if text.count == 0 {
                    self?.tableView.addInfiniteScroll { [weak self] tv in
                        self?.viewModel.callFetchPokemons.onNext(Void())
                        self?.tableView.finishInfiniteScroll()
                    }
                } else {
                    self?.tableView.setContentOffset(.zero, animated: false)
                    self?.tableView.removeInfiniteScroll()
                }
            })
            .bind(to: viewModel.findPokemonQuery)
            .disposed(by: disposeBag)
        
        showFavoritePokemonButton.rx.tap
            .do(onNext: viewModel.getFavoritePokemonsReady.onNext)
            .withLatestFrom(viewModel.getFavoritePokemons) { $1 }
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] favoritePokemons in
                if favoritePokemons.count > 0 {
                    let v = UIHostingController(rootView: FavoritePokemonsView(favoritePokemons: favoritePokemons))
                    self?.navigationController?.pushViewController(v, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Interactions
extension PokeDexListViewController {
    @objc func logoTapped() {
        tableView.setContentOffset(.zero, animated: true)
    }
}

// MARK: - Swipe Right to Pop Related
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
