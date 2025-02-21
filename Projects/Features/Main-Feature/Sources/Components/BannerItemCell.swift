//
//  BannerItemCell.swift
//  Main-Feature
//
//  Created by Daye on 2/18/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class BannerItemCell: UICollectionViewCell {

    private let stackView = UIStackView()
    private let logoImageView = UIImageView()
    private let titleLabel = ZetLabel(typography: .semiBold(.T14))
    private let descriptionLabel = ZetLabel(typography: .medium(.T12))

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

    }

    private func makeConstraints() {

    }

}
