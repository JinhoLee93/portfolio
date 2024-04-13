//
//  PokemonDetailViewController.swift
//  PokeDex
//
//  Created by Jinho Lee on 2/23/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

// MARK: - VC for the Pokemon Detail
class PokemonDetailViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private let viewModel: PokemonDetailViewModelType
    
    private let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.startAnimating()
        
        return view
    }()
    
    private let pokemonTopStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .fill
        
        return sv
    }()
    
    private let pokemonImageView: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    private let pokemonName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        
        return label
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(PokemonDetailTableViewCell.self, forCellReuseIdentifier: PokemonDetailTableViewCell.identifier)
        tv.allowsSelection = false
        
        return tv
    }()
    
    private let rxTableViewDataSource: RxTableViewSectionedReloadDataSource = {
        let dataSource = RxTableViewSectionedReloadDataSource<PokemonDetailSection>(configureCell: {
            datasource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonDetailTableViewCell.identifier, for: indexPath) as! PokemonDetailTableViewCell
            cell.pokemonDetail.onNext(item)
            
            return cell
        })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            dataSource.sectionModels[index].header
        }
        
        return dataSource
    }()
    
    init(viewModel: PokemonDetailViewModelType) {
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
    
    private func setUpUI() {
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        loadingView.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        view.addSubview(pokemonTopStackView)
        pokemonTopStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        pokemonTopStackView.addArrangedSubview(pokemonImageView)
        pokemonImageView.snp.makeConstraints {
            $0.height.equalTo(125)
            $0.width.equalTo(125)
        }
        pokemonTopStackView.addArrangedSubview(pokemonName)
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(pokemonTopStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
        view.bringSubviewToFront(loadingView)
    }
    
    private func bindViewModel() {
        viewModel.isLoadingViewHidden
            .asDriver(onErrorJustReturn: true)
            .drive(loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.pokemonImage
            .asDriver(onErrorJustReturn: UIImage(named: "Loading")!)
            .drive(pokemonImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.pokemonName
            .map { $0.localizedCapitalized }
            .asDriver(onErrorJustReturn: "")
            .drive(pokemonName.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.pokemonType
            .map { UIColor(TypeColorPattern(rawValue: $0)!.typeToColor) }
            .asDriver(onErrorJustReturn: UIColor(.indigo))
            .drive(pokemonName.rx.textColor)
            .disposed(by: disposeBag)
        
        viewModel.pokemonDetailSections
            .bind(to: tableView.rx.items(dataSource: rxTableViewDataSource))
            .disposed(by: disposeBag)
    }
}
