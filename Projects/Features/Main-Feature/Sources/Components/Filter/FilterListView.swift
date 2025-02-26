//
//  FilterListView.swift
//  Main-Feature
//
//  Created by Daye on 2/25/25.
//

import UIKit

import SnapKit

final class FilterListView: UIView {

    typealias Cell = ChipCell

    private enum Metric {
        static let groupSpacing: CGFloat = 6
        static let height: CGFloat = 30
    }

    struct State {
        let title: String
        let isSelected: Bool
    }

    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    )

    private var list: [State] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.collectionView.reloadData()
                self.selectItems(list: self.list)
            }
        }
    }

    /// Chips 선택 시 index 방출 closure
    var didSelectItem: ((Int) -> Void)?

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
        self.collectionView.collectionViewLayout = self.collectionViewLayout(groupSpacing: Metric.groupSpacing)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.allowsMultipleSelection = true
        self.collectionView.registerCell(type: Cell.self)
        self.collectionView.backgroundColor = .clear
    }

    private func makeConstraints() {
        self.addSubview(collectionView)

        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(Metric.height)
        }
    }

    /// 셀 선택 상태 반영을 위한 메소드
    private func selectItems(list: [State]) {
        guard !list.isEmpty else { return }

        list.enumerated().forEach { (index, element) in
            if element.isSelected {
                let indexPath = IndexPath(item: index, section: .zero)

                self.collectionView.selectItem(
                    at: indexPath,
                    animated: false,
                    scrollPosition: []
                )
            }
        }
    }

    func bind(state: [State]) {
        self.list = state
    }

}

extension FilterListView: UICollectionViewDataSource {
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
        let text = self.list[indexPath.item].title
        cell.setText(text)
        return cell
    }
}

extension FilterListView: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? Cell else { return }

        self.didSelectItem?(indexPath.item)

    }
}


extension FilterListView {
    func collectionViewLayout(groupSpacing: CGFloat) -> UICollectionViewLayout {
        let minimumValue: CGFloat = 1

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(minimumValue),
            heightDimension: .estimated(minimumValue)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(minimumValue),
            heightDimension: .estimated(minimumValue)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = groupSpacing

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal

        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = config

        return layout
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal_초기선택 O",
    traits: .sizeThatFitsLayout
) {
    let view = FilterListView()
    view.backgroundColor = .Gray800

    view.bind(state: [
        FilterListView.State(title: "쿠팡", isSelected: true),
        FilterListView.State(title: "G마켓", isSelected: false),
        FilterListView.State(title: "11번가", isSelected: false),
        FilterListView.State(title: "네이버", isSelected: false),
        FilterListView.State(title: "마켓컬리", isSelected: false),
        FilterListView.State(title: "마켓컬리", isSelected: false),
        FilterListView.State(title: "마켓컬리", isSelected: false)
    ])
    view.didSelectItem = { index in
        print("selected Index: \(index)")
    }

    return view
}

@available(iOS 17.0, *)
#Preview(
    "normal_초기선택 X",
    traits: .sizeThatFitsLayout
) {
    let view = FilterListView()
    view.bind(state: [
        FilterListView.State(title: "쿠팡", isSelected: true),
        FilterListView.State(title: "G마켓", isSelected: false),
        FilterListView.State(title: "11번가", isSelected: false),
        FilterListView.State(title: "네이버", isSelected: false),
    ])
    view.didSelectItem = { index in
        print("selected Index: \(index)")
    }

    return view
}
