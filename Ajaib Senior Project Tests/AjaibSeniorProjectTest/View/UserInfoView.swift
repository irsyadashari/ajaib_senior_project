//
//  UserInfoView.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 06/03/24.
//

import UIKit

final class UserInfoView: UIView {
    private lazy var photoImageView = UIImageView().parent(self)
    private lazy var nameLabel = UILabel().parent(self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func configure(viewParam: UserInfoCellViewParam) {
        if let imageProfile = viewParam.image {
            photoImageView.image = imageProfile
        }
        
        nameLabel.text = viewParam.name
    }
    
    private func setupView() {
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.backgroundContrastColor.cgColor
        
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        setupConstraint()
    }
    
    private func setupConstraint() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor).isActive = true
        
    }
}
