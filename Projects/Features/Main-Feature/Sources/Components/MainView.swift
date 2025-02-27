//
//  MainView.swift
//  Main-Feature
//
//  Created by Daye on 2/27/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class MainView: UIView {

    enum Section: Int, CaseIterable {
        case banner = 0
        case product = 1
    }

    struct State {
        let bannerList: [BannerListCell.State]
        let filterList: [AccordionView.State]
        let productList: [ProductItemCell.State]
    }

    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    )

    private let refreshControl = UIRefreshControl()

    private var state: State = .init(
        bannerList: [],
        filterList: [],
        productList: []
    ) {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }

    var refresh: (() async -> Void)?
    var selectFolded: ((Bool) -> Void)?

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
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            Task {
                await self.refresh?()
            }
        }
        self.refreshControl.addAction(action, for: .valueChanged)
        self.refreshControl.tintColor = .Red300

        self.collectionView.refreshControl = self.refreshControl
        self.collectionView.backgroundColor = .Gray800
        self.collectionView.collectionViewLayout = self.collectionViewLayout()
        self.collectionView.registerCell(type: BannerListCell.self)
        self.collectionView.registerCell(type: ProductListHeaderCell.self)
        self.collectionView.registerCell(type: ProductItemCell.self)
        self.collectionView.registHeaderFooter(type: ProductFilterHeaderView.self, kindType: .header)
        self.collectionView.dataSource = self
    }

    private func makeConstraints() {
        self.addSubview(collectionView)

        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }

    func bind(_ state: State) {
        self.state = state
    }
}

extension MainView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = Section(rawValue: indexPath.section)

        switch section {
        case .banner:
            let cell = collectionView.dequeueCell(
                withType: BannerListCell.self,
                for: indexPath
            )
            cell.bind(list: self.state.bannerList)

            return cell

        case .product:
            if indexPath.item == 0 {
                let cell = collectionView.dequeueCell(
                    withType: ProductListHeaderCell.self,
                    for: indexPath
                )
                return cell

            } else {
                let cell = collectionView.dequeueCell(
                    withType: ProductItemCell.self,
                    for: indexPath
                )
                cell.bind(state: self.state.productList[indexPath.item - 1])

                return cell
            }

        case .none:
            return UICollectionViewCell()
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let section = Section(rawValue: indexPath.section)
        guard section == .product, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }

        let header = collectionView.dequeueReusableHeaderFooter(
            withType: ProductFilterHeaderView.self,
            kindType: .header,
            for: indexPath
        )
        header.backgroundColor = .Gray800
        header.selectFolded = { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }

        header.bind(list: self.state.filterList)

        return header
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        let section = Section(rawValue: section)

        switch section {
        case .banner:
            return 1

        case .product:
            return self.state.productList.count + 1

        case .none:
            return 0
        }
    }
}

extension MainView {

    private enum Metric {
        static let horizontalInset: CGFloat = 20
        static let headerInset = NSDirectionalEdgeInsets(
            top: .zero,
            leading: horizontalInset,
            bottom: .zero,
            trailing: .zero
        )
        static let productGroupSpacing: CGFloat = 16
    }

    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {(section: Int, _) -> NSCollectionLayoutSection? in

            let section = Section(rawValue: section)

            switch section {
            case .banner:
                return self.bannerSectionLayout()

            case .product:
                return self.productSectionLayout()
            default:
                return nil
            }

        }

        return layout
    }

    func bannerSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(86)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(86)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(
            top: .zero,
            leading: Metric.horizontalInset,
            bottom: .zero,
            trailing: Metric.horizontalInset
        )

        return section
    }

    func productSectionLayout() -> NSCollectionLayoutSection {
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
        group.contentInsets = .init(
            top: .zero,
            leading: Metric.horizontalInset,
            bottom: .zero,
            trailing: Metric.horizontalInset
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Metric.productGroupSpacing

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(1)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.contentInsets = Metric.headerInset
        header.pinToVisibleBounds = true

        section.boundarySupplementaryItems = [header]


        return section

    }

}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIView()
    let view = MainView()

    contentView.backgroundColor = .Gray800
    contentView.addSubview(view)

    view.snp.makeConstraints {
        $0.edges.equalTo(contentView.safeAreaLayoutGuide)
    }

    view.bind(.init(
        bannerList:
            [
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
            ],
        filterList: Array(
            repeating: AccordionItemView.State(
                title: "쇼핑몰",
                list: [
                    FilterListView.State(title: "쿠팡", isSelected: true),
                    FilterListView.State(title: "G마켓", isSelected: false),
                    FilterListView.State(title: "11번가", isSelected: false),
                    FilterListView.State(title: "네이버", isSelected: false),
                    FilterListView.State(title: "마켓컬리", isSelected: false),
                    FilterListView.State(title: "마켓컬리", isSelected: false)
                ]
            ),
            count: 5
        ),
        productList: Array(
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
        ))
    )

    return contentView
}
