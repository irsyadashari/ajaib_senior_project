//
//  OptionView.swift
//  AjaibSeniorProjectTest
//
//  Created by Irsyad Ashari on 20/03/24.
//

import UIKit
import RxSwift
import RxCocoa

enum OptionViewType {
    case cta
    case text(text: String)
    case toggle
}

final class OptionView: UIView {
    private lazy var iconView = UIImageView().parent(self)
    private lazy var titleLabel = UILabel().parent(self)
    private lazy var contentLabel = UILabel().parent(self)
    private lazy var separatorView = UIView().parent(self)
    private lazy var toggleView = UISwitch().parent(self)
    private lazy var chevronButton = UIButton().parent(self)
    
    let rxEventToggleDidSwitched = PublishSubject<Bool>()
    let rxEventChevronDidTapped = PublishSubject<Void>()
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func configure(
        image: UIImage?,
        text: String,
        isUsingBorder: Bool = false,
        isUsingSeparator: Bool = false,
        type: OptionViewType
    ) {
        if isUsingBorder {
            self.layer.cornerRadius = 10.0
            self.layer.borderWidth = 1.0
            self.layer.borderColor = UIColor.backgroundContrastColor.cgColor
        }
        
        if let image {
            iconView.image = image
        }
        
        titleLabel.text = text
        
        separatorView.isHidden = !isUsingSeparator
        
        switch type {
            
        case .cta:
            contentLabel.isHidden = true
            toggleView.isHidden = true
            chevronButton.isHidden = false
        case .text(let text):
            contentLabel.isHidden = false
            toggleView.isHidden = true
            chevronButton.isHidden = true
            
            contentLabel.text = text
        case .toggle:
            toggleView.isHidden = false
            contentLabel.isHidden = true
            chevronButton.isHidden = true
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        separatorView.backgroundColor = UIColor.backgroundContrastColor
        
        chevronButton.setImage(UIImage(named: "icons-chevron"), for: .normal)
        //apa di setting dsini ?
        setupConstraint()
        setupRx()
    }
    
    private func setupRx() {
        toggleView.rx.isOn.asObservable()
            .subscribe(onNext: { [weak self] isOn in
                self?.rxEventToggleDidSwitched.onNext(isOn)
            }).disposed(by: disposeBag)
        
        chevronButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] isOn in
                self?.rxEventChevronDidTapped.onNext(())
            }).disposed(by: disposeBag)
    }
    
    private func setupConstraint() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        iconView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -16).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        toggleView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        toggleView.translatesAutoresizingMaskIntoConstraints = false
        toggleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        toggleView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        
        chevronButton.translatesAutoresizingMaskIntoConstraints = false
        chevronButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        chevronButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        chevronButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        chevronButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
