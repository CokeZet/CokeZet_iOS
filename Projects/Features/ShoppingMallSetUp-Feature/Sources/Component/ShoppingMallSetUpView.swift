//
//  ShoppingMallSetUpView.swift
//  ShoppingMallSetUp-Feature
//
//  Created by Daye on 2/16/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class ShoppingMallSetUpView: UIView {
    
    private let titleLabel = ZetLabel(typography: .semiBold(.T24))
    private let listView = ShoppingMallListView()
    private let confirmButton = ZetRoundButton()

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
