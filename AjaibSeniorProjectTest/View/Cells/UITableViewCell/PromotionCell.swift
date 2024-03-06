//
//  PromotionCell.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 06/03/24.
//

import UIKit
import RxSwift
import RxCocoa

class PromotionCell: UITableViewCell {
    private lazy var titleLabel = UILabel()
    private lazy var optionsStack = UIStackView()
    
    let rxEventChevronDidTapped = PublishSubject<Void>()
    let rxEventToggleDidSwitched = PublishSubject<Bool>()
    
    private let disposeBag = DisposeBag()
    
    private var isConfigured: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(optionsStack)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewParams: [OptionCellViewParam]) {
        titleLabel.text = "Promotion"
        
        optionsStack.clearSubviews()
        for (index, viewParam) in viewParams.enumerated() {
            let optionView = OptionView()
            let isUsingSeparator: Bool = index != 0
            optionView.configure(
                image: viewParam.image,
                text: viewParam.title,
                isUsingSeparator: isUsingSeparator,
                type: viewParam.cellType
            )
            
            optionView.rxEventChevronDidTapped.asObservable()
                .subscribe(onNext: { [weak self] in
                    self?.rxEventChevronDidTapped.onNext(())
            }).disposed(by: disposeBag)
            
            optionView.rxEventToggleDidSwitched.asObservable()
                .subscribe(onNext: { [weak self] isOn in
                    self?.rxEventToggleDidSwitched.onNext(isOn)
            }).disposed(by: disposeBag)
            
            optionsStack.addArrangedSubview(optionView)
        }
    }
    
    private func setupUI() {
        optionsStack.axis = .vertical
        optionsStack.spacing = 8
        optionsStack.layer.cornerRadius = 10.0
        optionsStack.layer.borderWidth = 1.0
        optionsStack.layer.borderColor = UIColor.black.cgColor
        optionsStack.distribution = .fillProportionally
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        optionsStack.translatesAutoresizingMaskIntoConstraints = false
        optionsStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        optionsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        optionsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        optionsStack.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    }
}
