//
//  ShoppingMallItemCell.swift
//  ShoppingMallSetUp-Feature
//
//  Created by Daye on 2/15/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class ShoppingMallItemCell: UICollectionViewCell {

    private enum Metric {
        static let spacing: CGFloat = 8
    }

    struct State {
        let image: UIImage?
        let title: String
    }

    private let stackView = UIStackView()
    private let choiceView = ChoiceView()
    private let titleLabel = ZetLabel(typography: .semiBold(.T16))

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
        self.stackView.axis = .vertical
        self.stackView.spacing = Metric.spacing
        self.stackView.alignment = .center

        self.titleLabel.textColor = .Gray500
        self.titleLabel.textAlignment = .center
    }

    private func makeConstraints() {
        self.addSubview(stackView)

        self.stackView.addArrangedSubview(choiceView)
        self.stackView.addArrangedSubview(titleLabel)

        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(state: State) {
        self.choiceView.setImage(state.image)
        self.titleLabel.text = state.title
    }

    func setChoiceState(_ state: ChoiceState) {
        self.choiceView.setState(state)

        switch state {
        case .active:
            self.titleLabel.textColor = .White
        case .normal:
            self.titleLabel.textColor = .Gray500
        }
    }
}
