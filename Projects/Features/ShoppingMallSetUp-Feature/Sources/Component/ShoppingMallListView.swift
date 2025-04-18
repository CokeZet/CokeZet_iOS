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

    /// 선택된 셀 개수 변경 시 호출되는 클로저
    var onSelectionChanged: ((Int) -> Void)?

    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    )

    private var list: [State] = [] {
        didSet {
            self.collectionView.reloadData()
            self.selectedIndexes.removeAll()
            self.onSelectionChanged?(0)
        }
    }

    /// 선택된 indexPath 저장 (ALL 선택 동작 구현을 위해)
    private var selectedIndexes: Set<Int> = []

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
        self.collectionView.allowsMultipleSelection = true
        self.collectionView.isScrollEnabled = false
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
        section.contentInsets = .init(top: 16, leading: 0, bottom: 16, trailing: 0)

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

        // 셀의 선택 상태를 반영
        if self.selectedIndexes.contains(indexPath.item) {
            cell.setChoiceState(.active)
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        } else {
            cell.setChoiceState(.normal)
            collectionView.deselectItem(at: indexPath, animated: false)
        }

        return cell
    }
}

extension ShoppingMallListView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        // ALL(전체) 셀이 첫 번째(0번) 인덱스라고 가정
        if indexPath.item == 0 {
            // ALL 선택 시 모든 셀 선택
            for i in 0..<self.list.count {
                self.selectedIndexes.insert(i)
                collectionView.selectItem(at: IndexPath(item: i, section: 0), animated: false, scrollPosition: [])
                if let cell = collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as? Cell {
                    cell.setChoiceState(.active)
                }
            }
        } else {
            self.selectedIndexes.insert(indexPath.item)
            if let cell = collectionView.cellForItem(at: indexPath) as? Cell {
                cell.setChoiceState(.active)
            }
        }
        self.onSelectionChanged?(self.selectedIndexes.count)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath
    ) {
        // ALL(전체) 셀이 비선택되면 전체 해제
        if indexPath.item == 0 {
            for i in 0..<self.list.count {
                self.selectedIndexes.remove(i)
                collectionView.deselectItem(at: IndexPath(item: i, section: 0), animated: false)
                if let cell = collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as? Cell {
                    cell.setChoiceState(.normal)
                }
            }
        } else {
            self.selectedIndexes.remove(indexPath.item)
            if let cell = collectionView.cellForItem(at: indexPath) as? Cell {
                cell.setChoiceState(.normal)
            }
            // ALL(전체) 셀이 선택되어 있다면 해제
            if self.selectedIndexes.contains(0) {
                self.selectedIndexes.remove(0)
                collectionView.deselectItem(at: IndexPath(item: 0, section: 0), animated: false)
                if let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? Cell {
                    cell.setChoiceState(.normal)
                }
            }
        }
        self.onSelectionChanged?(self.selectedIndexes.count)
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
