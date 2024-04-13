//
//  PokemonDetailTableViewCell.swift
//  PokeDex
//
//  Created by Jinho Lee on 3/16/24.
//

import Foundation
import UIKit
import RxSwift

// MARK: - Shows the Selected Pokmon's Skillsets
class PokemonDetailTableViewCell: UITableViewCell {
    static let identifier = "PokemonDetailTableViewCell"
    private let disposeBag = DisposeBag()
    
    private let pokemonDetailStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        
        return sv
    }()
    
    private let pokemonDetailLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let isSectionIndicator: AnyObserver<Bool>
    let pokemonDetail: AnyObserver<String>
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let prepareIsSectionIndicator = BehaviorSubject(value: false)
        let preparePokemonDetail = PublishSubject<String>()
        
        isSectionIndicator = prepareIsSectionIndicator.asObserver()
        
        pokemonDetail = preparePokemonDetail.asObserver()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
        
        preparePokemonDetail
            .asDriver(onErrorJustReturn: "")
            .drive(pokemonDetailLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setUpUI() {
        contentView.addSubview(pokemonDetailStack)
        pokemonDetailStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview()
        }
        pokemonDetailStack.addArrangedSubview(pokemonDetailLabel)
    }
}
