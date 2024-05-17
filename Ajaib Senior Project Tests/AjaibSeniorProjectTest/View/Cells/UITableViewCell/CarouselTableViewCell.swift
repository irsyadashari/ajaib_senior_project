//
//  CarouselTableViewCell.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 06/03/24.
//

import UIKit

class CarouselTableViewCell: UITableViewCell {
    private lazy var carouselView = CarouselView()
    private var isConfigured = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(carouselView)
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        
        carouselView.pinCenter(to: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(presenter: CarouselViewPresenter) {
        guard isConfigured == false else { return }
        carouselView.set(presenter: presenter)
        isConfigured = true
    }

}

