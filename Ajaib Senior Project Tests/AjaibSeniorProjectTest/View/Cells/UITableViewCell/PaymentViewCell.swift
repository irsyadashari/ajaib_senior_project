//
//  PaymentViewCell.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 06/03/24.
//

import UIKit

class PaymentViewCell: UITableViewCell {
    private lazy var paymentView  = PaymentView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(paymentView)
        paymentView.translatesAutoresizingMaskIntoConstraints = false
        
        paymentView.pinCenter(to: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        viewParam: PaymentCellViewParam
    ) {
        paymentView.configure(
            viewParam: viewParam
        )
    }

}
