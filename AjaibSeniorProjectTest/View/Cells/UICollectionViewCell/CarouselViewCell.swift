//
//  CarouselViewCell.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 06/03/24.
//

import UIKit

class CarouselViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = UILabel().parent(contentView)
    
    private var hasConfigured: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.textAlignment = .center
        titleLabel.pinCenter(to: contentView)
    }
    
    func configure(hexText: String) {
        guard hasConfigured == false else { return }
        titleLabel.text = hexText
        contentView.backgroundColor = hexText.hexStringToUIColor()
        hasConfigured = true
    }
}
