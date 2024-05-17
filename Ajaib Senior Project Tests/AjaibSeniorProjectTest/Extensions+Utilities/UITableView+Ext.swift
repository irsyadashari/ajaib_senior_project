//
//  UITableView+Ext.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 05/03/24.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

