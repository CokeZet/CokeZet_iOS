//
//  BannerItemCell.swift
//  Main-Feature
//
//  Created by Daye on 2/18/25.
//

import UIKit

import CokeZet_Components
import CokeZet_DesignSystem

import SnapKit

final class BannerItemCell: UICollectionViewCell {

    private enum Metric {
        static let cokeRight: CGFloat = 32
        static let cokeSize: CGFloat = 94

        static let inset: CGFloat = 12
        static let logoSize = CGSize(width: 45, height: 24)

        static let titleTop: CGFloat = 4
        static let descriptionTop: CGFloat = 8
    }

    struct State {
        let logoImage: UIImage
        let title: String
        let description: String
        let cokeImage: UIImage
        let bottleType: CokeType
    }

    private let logoImageView = UIImageView()
    private let titleLabel = ZetLabel(typography: .semiBold(.T14), textColor: .White)
    private let descriptionLabel = ZetLabel(typography: .medium(.T12), textColor: .Gray400)

    private let cokeView = UIView()

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
        self.contentView.backgroundColor = .Gray700
        self.contentView.layer.cornerRadius = 8
        self.contentView.clipsToBounds = true
    }

    private func makeConstraints() {
        self.contentView.addSubview(cokeView)
        self.contentView.addSubview(logoImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)

        self.cokeView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(Metric.cokeRight)
            $0.size.equalTo(Metric.cokeSize)
        }

        self.logoImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(Metric.inset)
            $0.size.equalTo(Metric.logoSize)
        }

        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(Metric.titleTop)
            $0.leading.equalToSuperview().offset(Metric.inset)
        }

        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.descriptionTop)
            $0.leading.equalToSuperview().offset(Metric.inset)
            $0.bottom.equalToSuperview().inset(Metric.inset)
        }
    }

    func bind(state: State) {
        self.setImageView(state: state)
        self.logoImageView.image = state.logoImage
        self.titleLabel.text = state.title
        self.descriptionLabel.text = state.description
    }

    private func setImageView(state: State) {
        let cokeImageView = CokeImageView(
            CokeImageView.State(
                leftCokeImage: state.cokeImage,
                rightCokeImage: state.cokeImage
            ),
            state.bottleType
        )

        self.cokeView.addSubview(cokeImageView)

        cokeImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIView()
    contentView.backgroundColor = .Gray800

    let view = BannerItemCell()
    contentView.addSubview(view.contentView)
    view.contentView.snp.makeConstraints {
        $0.edges.equalToSuperview().inset(20)

    }

    view.bind(
        state: BannerItemCell.State(
            logoImage: CokeZetDesignSystemAsset.icGs25.image,
            title: "[1+1] 펩시(디카페인) 라임 355ml",
            description: "개당 2000원",
            cokeImage: CokeZetDesignSystemAsset.icCanPepsiZeroCaffeine355.image,
            bottleType: .can
        )
    )

    return contentView
}
