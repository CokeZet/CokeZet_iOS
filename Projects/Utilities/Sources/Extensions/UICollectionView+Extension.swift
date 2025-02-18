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
    
    func registHeaderFooter(
        type: UICollectionReusableView.Type,
        kindType: CollectionViewHeaderFooterKind,
        identifier: String? = nil
    ) {
        let kind = kindType.kind
        let identifier = identifier ?? type.identifier
        self.register(
            type,
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: identifier
        )
    }

    func dequeueReusableHeaderFooter<Cell: UICollectionReusableView>(
        withType type: Cell.Type,
        kindType: CollectionViewHeaderFooterKind,
        identifier: String? = nil,
        for indexPath: IndexPath
    ) -> Cell {
        let identifier = identifier ?? type.identifier
        return self.dequeueReusableSupplementaryView(
            ofKind: kindType.kind,
            withReuseIdentifier: identifier,
            for: indexPath
        ) as! Cell
    }
}

public enum CollectionViewHeaderFooterKind {
    case header
    case footer

    var kind: String {
        switch self {
        case .header:
            return UICollectionView.elementKindSectionHeader
        case .footer:
            return UICollectionView.elementKindSectionFooter
        }
    }
}

