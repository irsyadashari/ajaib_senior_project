//
//  UIView+Ext.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 01/03/24.
//

import UIKit

extension UIView {
    func pinCenter(to superView: UIView, distance: Int = 0) {
        let distanceInPixel: CGFloat = CGFloat(distance) * UIScreen.main.scale
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: CGFloat(distanceInPixel/2)).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: CGFloat(-distanceInPixel)).isActive = true
        topAnchor.constraint(equalTo: superView.topAnchor, constant: CGFloat(distanceInPixel)).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: CGFloat(-distanceInPixel/2)).isActive = true
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

extension Notification.Name {
    static let userLoggedIn = Notification.Name("UserLoggedInNotification")
}

