//
//  ProductItemCell.swift
//  Main-Feature
//
//  Created by Daye on 2/16/25.
//

import UIKit

import SnapKit

final class ProductItemCell: UICollectionViewCell {

    typealias State = CardView.State

    private let cardView = CardView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeConstraints() {
        self.contentView.addSubview(cardView)

        self.cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(166)
        }
    }

    func bind(state: State) {
        self.cardView.bind(state: state)
    }
}
