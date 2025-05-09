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


    private var state: State = .init(
        bannerList: [],
        filterList: [],
        productList: []
    ) {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    var selectBanner: ((IndexPath) -> Void)?
    var selectFilter: ((IndexPath) -> Void)?
    var selectProduct: ((IndexPath) -> Void)?
    var selectMore: (() -> Void)?
    let isGuest: Bool

    init(isGuest: Bool) {
        self.isGuest = isGuest
        super.init(frame: .zero)
        self.addConfigure()
        self.makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConfigure() {
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.backgroundColor = .Gray800
        self.collectionView.collectionViewLayout = self.collectionViewLayout()
        self.collectionView.registerCell(type: BannerListCell.self)
        self.collectionView.registerCell(type: ProductListHeaderCell.self)
        self.collectionView.registerCell(type: ProductItemCell.self)
        self.collectionView.registerCell(type: DividerCell.self)
        self.collectionView.registHeaderFooter(type: ProductFilterHeaderView.self, kindType: .header)
        self.collectionView.registHeaderFooter(type: ProductListFooterView.self, kindType: .footer)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    private func makeConstraints() {
        self.addSubview(collectionView)

        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.horizontalEdges.equalToSuperview()
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

            cell.selectItem = { [weak self] indexPath in
                self?.selectBanner?(indexPath)
            }

            return cell

        case .product:
            if indexPath.item == 0 {
                let cell = collectionView.dequeueCell(withType: DividerCell.self, for: indexPath)
                return cell
                
            } else if indexPath.item == 1 {
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
                cell.bind(state: self.state.productList[indexPath.item - 2])

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
        switch kind {
        case UICollectionView.elementKindSectionHeader:

            guard section == .product else { return UICollectionReusableView() }

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
            header.selectItem = { [weak self] item in
                self?.selectFilter?(item)
            }

            header.bind(list: self.state.filterList)
            
            header.isGuestSetup(isGuest: isGuest)

            return header

        case UICollectionView.elementKindSectionFooter:

            guard section == .product else { return UICollectionReusableView() }

            let footer = collectionView.dequeueReusableHeaderFooter(
                withType: ProductListFooterView.self,
                kindType: .footer,
                for: indexPath
            )

            return footer

        default:
            return UICollectionReusableView()

        }

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
            return self.state.productList.count + 2

        case .none:
            return 0
        }
    }
}

extension MainView: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let section = Section(rawValue: indexPath.section)

        switch section {
        case .banner:
            return

        case .product:
            // 0번에 "100ml당 낮은 순으로 소개해 드려요"가 포함되어 있어 -1 한 값으로 전달
            // 2025년 04월 16일 (수요일) - Divider View 추가로 인해 -1 추가
            let indexPath = IndexPath(item: indexPath.item - 2, section: 0)
            
            if indexPath.item < 0 {
                return
            }
            
            self.selectProduct?(indexPath)

        case .none:
            return
        }
    }
}

extension MainView {

    private enum Metric {
        static let horizontalInset: CGFloat = 20
        static let headerInset = NSDirectionalEdgeInsets(
            top: .zero,
            leading: .zero,
            bottom: .zero,
            trailing: .zero
        )
        static let productGroupSpacing: CGFloat = 16
        static let footerHeight: CGFloat = 46 + 20 + 16
        static let footerInset = NSDirectionalEdgeInsets(
            top: 20,
            leading: 20,
            bottom: 16,
            trailing: 20
        )
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
            top: 22,
            leading: Metric.horizontalInset,
            bottom: .zero,
            trailing: Metric.horizontalInset
        )

        return section
    }

    func productSectionLayout() -> NSCollectionLayoutSection {
        let minimumValue: CGFloat = 166

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
            heightDimension: .estimated(302)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.contentInsets = Metric.headerInset
        header.pinToVisibleBounds = true

        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(Metric.footerHeight)
        )
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        footer.contentInsets = Metric.footerInset

        section.boundarySupplementaryItems = [header, footer]


        return section

    }

}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIView()
    let view = MainView(isGuest: false)

    contentView.backgroundColor = .Gray800
    contentView.addSubview(view)

    view.snp.makeConstraints {
        $0.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        $0.bottom.equalToSuperview()
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

    view.selectBanner = { index in
        print("banner \(index)")
    }

    view.selectProduct = { index in
        print("product \(index)")
    }

    view.selectFilter = { index in
        print("filter \(index)")
    }

    return contentView
}

final class DividerCell: UICollectionViewCell {

    let nullView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addConfigure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConfigure() {
        self.nullView.backgroundColor = UIColor.Gray900
        
        self.addSubview(nullView)
        
        nullView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(-20)
            $0.trailing.equalToSuperview().offset(20)
            $0.height.equalTo(8)
        }
    }
}
