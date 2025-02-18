//
//  UICollectionView+Extension.swift
//  CokeZet-Utilities
//
//  Created by Daye on 2/15/25.
//

import UIKit

public extension UICollectionView {
    func registerCell(
        type: UICollectionViewCell.Type,
        identifier: String? = nil
    ) {
        let identifier = identifier ?? type.identifier
        self.register(type, forCellWithReuseIdentifier: identifier)
    }

    func dequeueCell<Cell: UICollectionViewCell>(
        withType type: Cell.Type,
        identifier: String? = nil,
        for indexPath: IndexPath
    ) -> Cell {
        let identifier = identifier ?? type.identifier
        return self.dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath
        ) as! Cell
    }
}
