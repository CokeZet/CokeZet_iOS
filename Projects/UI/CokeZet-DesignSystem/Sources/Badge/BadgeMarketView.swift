//
//  BadgeMarketView.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 2/12/25.
//

import UIKit

import SnapKit

public final class BadgeMarketView: UIView {

    private enum Metric {
        static let size: CGSize = CGSize(width: 34, height: 40)
    }

    private let imageView = UIImageView()

    public init() {
        super.init(frame: .zero)
        self.makeConstraints()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeConstraints() {
        self.addSubview(imageView)

        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.size.equalTo(Metric.size)
        }
    }

    public func setImage(_ image: UIImage) {
        self.imageView.image = image
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let view = BadgeMarketView()

    view.setImage(CokeZetDesignSystemAsset.icMarketNaver.image)

    return view
}
