//
//  LogoutCell.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 01/03/24.
//

import UIKit

class LogoutCell: UITableViewCell {
    private lazy var optionView : OptionView = OptionView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(optionView)
        optionView.translatesAutoresizingMaskIntoConstraints = false
        
        optionView.pinCenter(to: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        optionView.configure(
            image: UIImage(named: "diamond-points"),
            text: "Logout",
            isUsingBorder: true, type: .text(text: "")
        )
    }

}
