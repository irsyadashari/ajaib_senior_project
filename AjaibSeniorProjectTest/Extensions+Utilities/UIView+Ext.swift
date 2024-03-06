//
//  UIView+Ext.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 01/03/24.
//

import UIKit

extension UIView {
    func pinCenter(to superView: UIView, distance: Int = 0) {
        let distanceInPixel = CGFloat(distance)
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: CGFloat(distanceInPixel)).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: CGFloat(distanceInPixel)).isActive = true
        topAnchor.constraint(equalTo: superView.topAnchor, constant: CGFloat(distanceInPixel)).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: CGFloat(-distanceInPixel)).isActive = true
    }
    
    @discardableResult
    func parent(_ view: UIView) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        return self
    }
    
    func clearSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
