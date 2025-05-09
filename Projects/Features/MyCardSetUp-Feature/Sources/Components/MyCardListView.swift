//
//  MyCardListView.swift
//  MyCardSetUp-Feature
//
//  Created by Daye on 2/18/25.
//

import UIKit

import CokeZet_DesignSystem
import CokeZet_Utilities

import SnapKit

final class MyCardListView: UIView {

    typealias State = MyCardItemCell.State
    typealias Cell = MyCardItemCell

    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    )

    private var list: [State] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    /// 선택 상태 변경 콜백
    var onSelectionChanged: ((Bool) -> Void)?

    // 선택된 indexPath 저장
    private var selectedIndexes: Set<IndexPath> = []

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
        self.collectionView.allowsMultipleSelection = true
        self.collectionView.delegate = self
    }

    private func makeConstraints() {
        self.addSubview(collectionView)

        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }

    public func bind(list: [State]) {
        self.list = list
    }
    
    public func getSelectList() -> [Int] {
        return selectedIndexes.map{$0.row}.sorted(by: <)
    }
}

extension MyCardListView {
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

extension MyCardListView: UICollectionViewDataSource {
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

extension MyCardListView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? Cell else { return }
        cell.setChoiceState(.active)
        selectedIndexes.insert(indexPath)
        onSelectionChanged?(selectedIndexes.count > 0)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? Cell else { return }
        cell.setChoiceState(.normal)
        selectedIndexes.remove(indexPath)
        onSelectionChanged?(selectedIndexes.count > 0)
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let view = MyCardListView()

    view.backgroundColor = .Gray800

    view.bind(list: [
        MyCardListView.State(image: CokeZetDesignSystemAsset.icNh.image, title: "농협"),
        MyCardListView.State(image: CokeZetDesignSystemAsset.icKb.image, title: "국민"),
        MyCardListView.State(image: CokeZetDesignSystemAsset.icShinhan.image, title: "신한"),
        MyCardListView.State(image: CokeZetDesignSystemAsset.icLotteCard.image, title: "롯데"),
        MyCardListView.State(image: CokeZetDesignSystemAsset.icHana.image, title: "하나"),
        MyCardListView.State(image: CokeZetDesignSystemAsset.icSamsung.image, title: "삼성"),
        MyCardListView.State(image: CokeZetDesignSystemAsset.icHyundai.image, title: "현대"),
    ])

    return view
}
