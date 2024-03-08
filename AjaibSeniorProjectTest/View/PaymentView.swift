//
//  PaymentView.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 06/03/24.
//

import UIKit

final class PaymentView: UIView {
    private lazy var titletBalanceLabel = UILabel().parent(self)
    private lazy var valueBalanceLabel = UILabel().parent(self)
    private lazy var iconsContainer = UIStackView().parent(self)
    private lazy var processBalanceContainer = UIView().parent(self)
    private lazy var processBalanceTitleLabel = UILabel().parent(processBalanceContainer)
    private lazy var processBalanceValueLabel = UILabel().parent(processBalanceContainer)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func configure(viewParam: PaymentCellViewParam) {
        titletBalanceLabel.text = viewParam.titleBalance
        valueBalanceLabel.text = viewParam.valueBalance
        processBalanceTitleLabel.text = viewParam.titleInProcessBalance
        processBalanceValueLabel.text = viewParam.valueInProcessBalance
    }
    
    private func setupView() {
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.backgroundContrastColor.cgColor
        
        iconsContainer.distribution = .fillEqually
        iconsContainer.spacing = 8
        for _ in 1...3 {
            let image = UIImage(named: "diamond-points")
            let imageView = UIImageView(image: image)
            iconsContainer.addArrangedSubview(imageView)
        }
    
        processBalanceContainer.layer.cornerRadius = 10.0
        processBalanceContainer.layer.borderWidth = 1.0
        processBalanceContainer.layer.borderColor = UIColor.black.cgColor
        
        setupConstraint()
    }
    
    private func setupConstraint() {
        titletBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        titletBalanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        titletBalanceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        
        valueBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        valueBalanceLabel.leadingAnchor.constraint(equalTo: titletBalanceLabel.leadingAnchor).isActive = true
        valueBalanceLabel.topAnchor.constraint(equalTo: titletBalanceLabel.bottomAnchor, constant: 8).isActive = true
        
        iconsContainer.translatesAutoresizingMaskIntoConstraints = false
        iconsContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        iconsContainer.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        iconsContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconsContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        
        processBalanceContainer.translatesAutoresizingMaskIntoConstraints = false
        processBalanceContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        processBalanceContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        processBalanceContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        processBalanceContainer.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        processBalanceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        processBalanceTitleLabel.leadingAnchor.constraint(equalTo: processBalanceContainer.leadingAnchor, constant: 8).isActive = true
        processBalanceTitleLabel.centerYAnchor.constraint(equalTo: processBalanceContainer.centerYAnchor).isActive = true
        
        processBalanceValueLabel.translatesAutoresizingMaskIntoConstraints = false
        processBalanceValueLabel.trailingAnchor.constraint(equalTo: processBalanceContainer.trailingAnchor, constant: -8).isActive = true
        processBalanceValueLabel.centerYAnchor.constraint(equalTo: processBalanceContainer.centerYAnchor).isActive = true
        
    }
}
