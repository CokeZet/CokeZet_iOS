//
//  ProductListFooterView.swift
//  Main-Feature
//
//  Created by Daye on 2/27/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class ProductListFooterView: UICollectionReusableView {

    private let button = ZetSmallButton(buttonState: .normal)

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
        self.button.setTitle("더보기", for: .normal)
    }

    private func makeConstraints() {
        self.addSubview(button)

        self.button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
