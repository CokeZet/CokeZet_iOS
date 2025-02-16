//
//  ShoppingMallListView.swift
//  ShoppingMallSetUp-Feature
//
//  Created by Daye on 2/15/25.
//

import UIKit

import CokeZet_DesignSystem
import CokeZet_Utilities

import SnapKit

final class ShoppingMallListView: UIView {

    typealias State = ShoppingMallItemCell.State
    typealias Cell = ShoppingMallItemCell

    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    )

    private var list: [State] = [] {
        didSet {
            self.collectionView.reloadData()
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
        self.collectionView.collectionViewLayout = self.collectionViewLayout()
        self.collectionView.registerCell(type: Cell.self)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.allowsMultipleSelection = true
    }

    private func makeConstraints() {
        self.addSubview(collectionView)

        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }

    func bind(list: [State]) {
        self.list = list
    }
}

extension ShoppingMallListView {
    private func collectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25),
            heightDimension: .estimated(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(1)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )


        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20

        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension ShoppingMallListView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.list.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(
            withType: Cell.self,
            for: indexPath
        )

        cell.bind(state: self.list[indexPath.item])

        return cell
    }
}

extension ShoppingMallListView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? Cell else { return }
        cell.setChoiceState(.active)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? Cell else { return }
        cell.setChoiceState(.normal)
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {

    let view = ShoppingMallListView()

    view.bind(list: [
        ShoppingMallListView.State(image: nil, title: "전체"),
        ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icNaver.image, title: "네이버"),
        ShoppingMallListView.State(image: CokeZetDesignSystemAsset.ic11st.image, title: "11번가"),
        ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icCoupang.image, title: "쿠팡"),
        ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icGmarket.image, title: "지마켓"),
        ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icCurly.image, title: "마켓컬리"),
        ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icNaver.image, title: "네이버"),
        ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icNaver.image, title: "네이버"),
    ])

    return view
}
