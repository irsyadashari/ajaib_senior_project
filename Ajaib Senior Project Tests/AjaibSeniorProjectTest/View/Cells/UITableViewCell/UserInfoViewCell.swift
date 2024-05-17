//
//  UserInfoViewCell.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 06/03/24.
//

import UIKit

class UserInfoViewCell: UITableViewCell {
    private lazy var userInfoView  = UserInfoView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(userInfoView)
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        userInfoView.pinCenter(to: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        viewParam: UserInfoCellViewParam
    ) {
        userInfoView.configure(
            viewParam: viewParam
        )
    }

}
