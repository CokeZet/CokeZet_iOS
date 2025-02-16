//
//  CardInfoView.swift
//  Main-Feature
//
//  Created by Daye on 2/16/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class CardInfoView: UIView {

    private enum Metric {
        static let spacing: CGFloat = 12
        static let infoSpacing: CGFloat = 8
        static let priceSpacing: CGFloat = 4
        static let imageHeight: CGFloat = 60
        static let imageContainerSize: CGFloat = 72
    }

    struct State {
        let image: UIImage
//        let badge: BadgeState
        let productName: String
        let discountRate: Int
        let price: Int
        let isDeliveryFee: Bool
    }

    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let imageContainerView = UIView()

    private let infoStackView = UIStackView()
    private let badgeView = UIView() // 임시
    private let productNameLabel = ZetLabel(typography: .semiBold(.T14), textColor: .White)

    private let priceStackView = UIStackView()
    private let discountRateLabel = ZetLabel(typography: .semiBold(.T16), textColor: .Red500)
    private let priceLabel = ZetLabel(typography: .semiBold(.T16), textColor: .White)
    private let deliveryFeeLabel = ZetLabel(typography: .medium(.T12), textColor: .Red100)

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

        self.imageContainerView.backgroundColor = .Gray600
        self.imageContainerView.layer.cornerRadius = 4
        self.imageView.contentMode = .scaleAspectFit

        self.infoStackView.axis = .vertical
        self.infoStackView.spacing = Metric.infoSpacing
        self.infoStackView.alignment = .leading

        self.priceStackView.axis = .horizontal
        self.priceStackView.spacing = Metric.priceSpacing

        self.deliveryFeeLabel.text = "배송비 포함"
    }

    private func makeConstraints() {
        self.addSubview(stackView)

        self.imageContainerView.addSubview(imageView)
        self.stackView.addArrangedSubview(imageContainerView)
        self.stackView.addArrangedSubview(infoStackView)

        self.infoStackView.addArrangedSubview(badgeView)
        self.infoStackView.addArrangedSubview(productNameLabel)
        self.infoStackView.addArrangedSubview(priceStackView)

        self.priceStackView.addArrangedSubview(discountRateLabel)
        self.priceStackView.addArrangedSubview(priceLabel)
        self.priceStackView.addArrangedSubview(deliveryFeeLabel)

        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.imageContainerView.snp.makeConstraints {
            $0.size.equalTo(Metric.imageContainerSize)
        }

        self.imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(Metric.imageHeight)
        }
    }

    func bind(state: State) {
        self.imageView.image = state.image
        self.productNameLabel.text = state.productName
        self.discountRateLabel.text = "\(state.discountRate)%"
        self.priceLabel.text = "\(state.price.decimalFormat)원"
        self.deliveryFeeLabel.isHidden = !state.isDeliveryFee
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIView()
    contentView.backgroundColor = .Gray700

    let view = CardInfoView()
    contentView.addSubview(view)
    view.snp.makeConstraints {
        $0.edges.equalToSuperview()
    }

    view.bind(
        state: CardInfoView.State(
            image: CokeZetDesignSystemAsset.icCanCoca250.image,
            productName: "코카 콜라 250ml 24개",
            discountRate: 24,
            price: 16000,
            isDeliveryFee: true
        )
    )

    return contentView
}


