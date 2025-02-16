//
//  CardBenefitView.swift
//  Main-Feature
//
//  Created by Daye on 2/16/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class CardBenefitView: UIView {

    private enum Metric {
        static let spacing: CGFloat = 16
        static let badgeSpacing: CGFloat = 6
        static let badgeSize: CGFloat = 20
    }

    struct State {
        let list: [UIImage]
    }

    private let stackView = UIStackView()

    private let titleLabel = ZetLabel(typography: .semiBold(.T14), textColor: .Gray500)
    private let badgeStackView = UIStackView()

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
        self.stackView.axis = .horizontal
        self.stackView.spacing = Metric.spacing
        self.stackView.alignment = .top

        self.titleLabel.text = "카드혜택"

        self.badgeStackView.axis = .horizontal
        self.badgeStackView.spacing = Metric.badgeSpacing
        self.badgeStackView.setContentHuggingPriority(.required, for: .horizontal)
    }

    private func makeConstraints() {
        self.addSubview(stackView)
        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(badgeStackView)
        self.stackView.addArrangedSubview(UIView())

        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(state: State) {
        state.list.forEach {
            let badgeView = UIImageView() // 임시
            badgeView.image = $0

            badgeView.snp.makeConstraints {
                $0.size.equalTo(Metric.badgeSize)
            }

            self.badgeStackView.addArrangedSubview(badgeView)
        }
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIView()
    contentView.backgroundColor = .Gray700

    let view = CardBenefitView()
    contentView.addSubview(view)
    view.snp.makeConstraints {
        $0.edges.equalToSuperview()
    }

    view.bind(state: CardBenefitView.State(list: [
        CokeZetDesignSystemAsset.icShinhan.image,
        CokeZetDesignSystemAsset.icKb.image,
        CokeZetDesignSystemAsset.icLotteCard.image,
        CokeZetDesignSystemAsset.icHyundai.image,
        CokeZetDesignSystemAsset.icSamsung.image,
    ]))

    return contentView
}
