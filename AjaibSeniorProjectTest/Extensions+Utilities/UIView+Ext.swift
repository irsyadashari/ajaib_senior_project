//
//  UIView+Ext.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 01/03/24.
//

import UIKit

extension UIView {
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
    }
    
    @discardableResult
    func parent(_ view: UIView) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        return self
    }
}
