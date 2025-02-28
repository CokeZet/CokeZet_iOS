//
//  BannerListCell.swift
//  Main-Feature
//
//  Created by Daye on 2/26/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class BannerListCell: UICollectionViewCell {

    typealias Cell = BannerItemCell
    typealias State = Cell.State

    private enum Metric {
        static let inset: CGFloat = 12
    }

    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    )

    private let indicatorView = BannerIndicatorView()

    var selectItem: ((IndexPath) -> Void)?

    private var list: [State] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.indicatorView.setCurrentIndex(1)
                self.indicatorView.setTotalIndex(self.list.count)
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
        self.collectionView.collectionViewLayout = self.collectionViewLayout()
        self.collectionView.registerCell(type: Cell.self)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
    }

    private func makeConstraints() {
        self.contentView.addSubview(collectionView)
        self.contentView.addSubview(indicatorView)

        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }

        self.indicatorView.snp.makeConstraints {
            $0.top.equalTo(self.collectionView).offset(Metric.inset)
            $0.trailing.equalTo(self.collectionView).offset(-Metric.inset)
        }
    }

    func bind(list: [State]) {
        self.list = list
    }

}

extension BannerListCell: UICollectionViewDataSource {
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
        let cell = collectionView.dequeueCell(withType: Cell.self, for: indexPath)
        let item = self.list[indexPath.item]
        cell.bind(state: item)

        return cell
    }
}

extension BannerListCell: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        self.selectItem?(indexPath)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        let width = scrollView.bounds.width

        let page = Int(round(contentOffsetX / width)) + 1
        self.indicatorView.setCurrentIndex(page)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.width
        let contentOffsetX = scrollView.contentOffset.x

        let page = Int(round(contentOffsetX / width)) + 1
        self.indicatorView.setCurrentIndex(page)
    }
}

extension BannerListCell {
    func collectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(86)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(86)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal

        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        return layout
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let view = BannerListCell()

    view.snp.makeConstraints {
        $0.height.equalTo(86)
    }

    view.bind(
        list: [
            BannerItemCell.State(
                logoImage: CokeZetDesignSystemAsset.icGs25.image,
                title: "[1+1] 펩시(디카페인) 라임 355ml",
                description: "개당 2000원",
                cokeImage: CokeZetDesignSystemAsset.icCanPepsiZeroCaffeine355.image,
                bottleType: .can
            ),
            BannerItemCell.State(
                logoImage: CokeZetDesignSystemAsset.icGs25.image,
                title: "[1+1] 펩시(디카페인) 라임 355ml",
                description: "개당 2000원",
                cokeImage: CokeZetDesignSystemAsset.icPetCoca500.image,
                bottleType: .pet
            ),
            BannerItemCell.State(
                logoImage: CokeZetDesignSystemAsset.icGs25.image,
                title: "[1+1] 펩시(디카페인) 라임 355ml",
                description: "개당 2000원",
                cokeImage: CokeZetDesignSystemAsset.icCanCocaLemon190.image,
                bottleType: .can
            ),
            BannerItemCell.State(
                logoImage: CokeZetDesignSystemAsset.icGs25.image,
                title: "[1+1] 펩시(디카페인) 라임 355ml",
                description: "개당 2000원",
                cokeImage: CokeZetDesignSystemAsset.icCanCocaLemon190.image,
                bottleType: .can
            )
        ]
    )

    return view
}
