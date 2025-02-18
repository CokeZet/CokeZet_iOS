//
//  ProductInfomationView.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/3/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit
import Then
import CokeZet_Components
import SwiftUI

final class ProductInfomationView: UIView {
    
    // MARK: - UI Components
    private let titleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .leading
    }
    
    private let productTypeLabel = ZetLabel(typography: .semiBold(.T14), textColor: ZetColor.Gray600.color).then {
        $0.text = "코카콜라 음료"
    }
    
    private let titleLabel = ZetLabel(typography: .semiBold(.T20), textColor: ZetColor.White.color).then {
        $0.text = "코카콜라 제로 190ml (12개)"
    }
    
    private let productStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .leading
        $0.distribution = .fill
    }
    
    private let minimumPriceStackView = KeyValueStackView()
        .setKeyValue("최저가", "13000원")
        .setLargeValue()
    
    private let pricePer100mlStackView = KeyValueStackView()
        .setKeyValue("100ml", "193원")
    
    private let sellerStackView = KeyValueStackView()
        .setKeyValue("판매처", "")
        .setImage(CokeZetDesignSystemAsset.alertCircle.image)
    
    private let shippingFeeStackView = KeyValueStackView()
        .setKeyValue("배송비", "3000원", .deliveryPrice)
    
    private let cardDiscountStackView = KeyValueStackView()
        .setKeyValue("카드할인", "신한카드 12300원", .cardSale)
        .addToolTip()
    
    // MARK: - Constants
    private enum Layout {
        static let productStackTopSpacing: CGFloat = 12
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Setup
    private func setupLayout() {
        // Add Subviews
        [titleStackView, productStackView].forEach {
            addSubview($0)
        }
        
        // Add Subviews to Title Stack
        [productTypeLabel, titleLabel].forEach {
            titleStackView.addArrangedSubview($0)
        }
        
        // Add Subviews to Product Stack
        [minimumPriceStackView, pricePer100mlStackView, sellerStackView, shippingFeeStackView, cardDiscountStackView].forEach {
            productStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        // Title Stack Constraints
        titleStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        // Product Stack Constraints
        productStackView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(Layout.productStackTopSpacing)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
