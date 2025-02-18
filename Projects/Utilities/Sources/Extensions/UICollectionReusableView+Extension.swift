//
//  UICollectionReusableView+Extension.swift
//  CokeZet-Utilities
//
//  Created by Daye on 2/15/25.
//

import UIKit

public extension UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
