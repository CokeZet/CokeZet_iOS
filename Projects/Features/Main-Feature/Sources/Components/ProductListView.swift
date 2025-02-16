//
//  ProductListHeaderView.swift
//  Main-Feature
//
//  Created by Daye on 2/16/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class ProductListView: UIView {

    private enum Metric {
        static let headerHeight: CGFloat = 34
        static let headerInset: CGFloat = 16
    }

    private let headerView = ProductListHeaderView()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addConfigure()
        self.makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConfigure() {

    }

    private func makeConstraints() {

    }

}

extension ProductListView {
    func collectionViewLayout(
        headerHeight: CGFloat?,
        headerInset: NSDirectionalEdgeInsets?,
        groupSpacing: CGFloat,
        contentInset: NSDirectionalEdgeInsets?
    ) -> UICollectionViewLayout {
        let minimumValue: CGFloat = 1

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(minimumValue)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(minimumValue)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = groupSpacing
        section.contentInsets = contentInset ?? .zero

        if let headerHeight {
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(headerHeight)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            header.contentInsets = headerInset ?? .zero

            section.boundarySupplementaryItems = [header]
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical

        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = config

        return layout
    }
}
