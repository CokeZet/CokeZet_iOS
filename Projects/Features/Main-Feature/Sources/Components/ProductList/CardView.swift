//
//  CardView.swift
//  Main-Feature
//
//  Created by Daye on 2/16/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class CardView: UIView {

    private enum Metric {
        static let cornerRadius: CGFloat = 8
        static let spacing: CGFloat = 16
        static let verticalInset: CGFloat = 17
        static let horizontalInset: CGFloat = 16
        static let separatorHeight: CGFloat = 1
    }

    struct State {
        let market: UIImage
        let info: CardInfoView.State
        let benefit: CardBenefitView.State
    }

    private let containerView = UIView()
    private let marketBadgeView = BadgeMarketView()

    private let stackView = UIStackView()
    private let infoView = CardInfoView()
    private let separatorView = UIView()
    private let benefitView = CardBenefitView()

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
        self.containerView.backgroundColor = .Gray700
        self.containerView.layer.cornerRadius = Metric.cornerRadius
        self.containerView.clipsToBounds = true

        self.stackView.axis = .vertical
        self.stackView.spacing = Metric.spacing

        self.separatorView.backgroundColor = .Gray600
    }

    private func makeConstraints() {
        self.addSubview(containerView)
        self.containerView.addSubview(marketBadgeView)
        self.containerView.addSubview(stackView)

        self.stackView.addArrangedSubview(infoView)
        self.stackView.addArrangedSubview(separatorView)
        self.stackView.addArrangedSubview(benefitView)

        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.marketBadgeView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-Metric.horizontalInset)
        }

        self.stackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Metric.verticalInset)
            $0.horizontalEdges.equalToSuperview().inset(Metric.horizontalInset)
        }

        self.separatorView.snp.makeConstraints {
            $0.height.equalTo(Metric.separatorHeight)
        }
    }

    func bind(state: State) {
        self.marketBadgeView.setImage(state.market)
        self.infoView.bind(state: state.info)
        self.benefitView.bind(state: state.benefit)
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIView()
    contentView.backgroundColor = .black

    let view = CardView()
    contentView.addSubview(view)
    view.snp.makeConstraints {
        $0.edges.equalToSuperview()
        $0.width.equalTo(384)
    }

    view.bind(
        state: CardView.State(
            market: CokeZetDesignSystemAsset.icMarket11st.image,
            info: CardInfoView.State(
                image: CokeZetDesignSystemAsset.icCanPepsi355.image,
                discountRateType: .zetPick,
                productName: "코카 콜라 250ml 24개",
                discountRate: 24,
                price: 16000,
                isDeliveryFee: true
            ),
            benefit: CardBenefitView.State(list: [
                CokeZetDesignSystemAsset.icShinhan.image,
                CokeZetDesignSystemAsset.icKb.image,
                CokeZetDesignSystemAsset.icLotteCard.image,
                CokeZetDesignSystemAsset.icHyundai.image,
                CokeZetDesignSystemAsset.icSamsung.image,
            ]
        )
    ))

    return contentView
}
