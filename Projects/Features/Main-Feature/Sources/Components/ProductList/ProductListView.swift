//
//  ProductListView.swift
//  Main-Feature
//
//  Created by Daye on 2/16/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class ProductListView: UICollectionViewCell {

    typealias Cell = ProductItemCell
    typealias State = Cell.State
    typealias Header = ProductListHeaderCell

    private enum Metric {
        static let headerHeight: CGFloat = 34 + (verticalInset * 2)
        static let verticalInset: CGFloat = 16
        static let horizontalInset: CGFloat = 20
        static let headerInset = NSDirectionalEdgeInsets(
            top: verticalInset,
            leading: .zero,
            bottom: verticalInset,
            trailing: .zero
        )
        static let contentInset = NSDirectionalEdgeInsets(
            top: .zero,
            leading: horizontalInset,
            bottom: .zero,
            trailing: horizontalInset
        )
        static let cardHeight: CGFloat = 158
    }

    private let headerView = ProductListHeaderCell()
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    )

    private var list: [State] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

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
        self.collectionView.backgroundColor = .clear
        self.collectionView.dataSource = self
        self.collectionView.registerCell(type: Cell.self)
        self.collectionView.collectionViewLayout = self.collectionViewLayout(
            headerHeight: Metric.headerHeight,
            headerInset: Metric.headerInset,
            groupSpacing: Metric.verticalInset,
            contentInset: Metric.contentInset
        )
        self.collectionView.registHeaderFooter(type: Header.self, kindType: .header)
    }

    private func makeConstraints() {
        self.contentView.addSubview(collectionView)

        self.collectionView.snp.makeConstraints {
            $0.edges.height.equalToSuperview()
        }
    }

    func bind(list: [State]) {
        self.list = list
    }

}

extension ProductListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(withType: Cell.self, for: indexPath)
        cell.bind(state: self.list[indexPath.item])

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableHeaderFooter(
                withType: Header.self,
                kindType: .header,
                for: indexPath
            )

            return header
        }

        return UICollectionReusableView()
    }

}

extension ProductListView {
    func collectionViewLayout(
        headerHeight: CGFloat?,
        headerInset: NSDirectionalEdgeInsets?,
        groupSpacing: CGFloat,
        contentInset: NSDirectionalEdgeInsets?
    ) -> UICollectionViewLayout {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(Metric.cardHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(Metric.cardHeight)
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

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIView()
    contentView.backgroundColor = .Gray800

    let view = ProductListView()
    contentView.addSubview(view)
    view.snp.makeConstraints {
        $0.edges.equalToSuperview()
    }

    view.bind(
        list: Array(
            repeating: ProductItemCell.State(
                market: CokeZetDesignSystemAsset.icMarket11st.image,
                info: CardInfoView.State(
                    image: CokeZetDesignSystemAsset.icCanPepsi355.image,
                    discountRateType: .zetPick,
                    productName: "코카 콜라 250ml 24개",
                    discountRate: 24,
                    price: 16000,
                    isDeliveryFee: true
                ),
                benefit: CardBenefitView.State(
                    list: [
                        CokeZetDesignSystemAsset.icShinhan.image,
                        CokeZetDesignSystemAsset.icKb.image,
                        CokeZetDesignSystemAsset.icLotteCard.image,
                        CokeZetDesignSystemAsset.icHyundai.image,
                        CokeZetDesignSystemAsset.icSamsung.image,
                    ]
                )
            ),
            count: 10
        )
    )

    return contentView
}
