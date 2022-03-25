//
//  UICollectionViewCell+Extensions.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import UIKit

public extension UICollectionViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

