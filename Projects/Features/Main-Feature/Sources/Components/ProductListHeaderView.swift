//
//  ProductListHeaderView.swift
//  Main-Feature
//
//  Created by Daye on 2/16/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class ProductListHeaderView: UIView {

    private enum Metric {
        static let cornerRadius: CGFloat = 17
        static let borderWidth: CGFloat = 1
        static let verticalInset: CGFloat = 10
        static let horizontalInset: CGFloat = 12
    }

    private let label = ZetLabel(typography: .semiBold(.T14), textColor: .Gray500)

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
        self.layer.cornerRadius = Metric.cornerRadius
        self.layer.borderWidth = Metric.borderWidth
        self.layer.borderColor = UIColor.Gray700.cgColor

        self.label.text = "*100ml당 가격이 낮은 순으로 소개해 드려요."
    }

    private func makeConstraints() {
        self.addSubview(label)

        self.label.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Metric.verticalInset)
            $0.horizontalEdges.equalToSuperview().inset(Metric.horizontalInset)
        }
    }
}
