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
    
    private let pricePer100mlStackView = KeyValueStackView()
    
    private let sellerStackView = KeyValueStackView()
    
    private let shippingFeeStackView = KeyValueStackView()
    
    private let cardDiscountStackView = KeyValueStackView()
    
    public struct State {
        var priceText: String
        var permlPrice: String
        var sellerImage: UIImage
        var shipFeetext: String
        var carddiscountText: String
    }
    
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
    
    public func bind(_ state: State) {
        minimumPriceStackView.setKeyValue("최저가", state.priceText)
        minimumPriceStackView.setLargeValue()
        
        pricePer100mlStackView.setKeyValue("100ml당", state.permlPrice)
        
        sellerStackView.setKeyValue("판매처", "")
        sellerStackView.setImage(state.sellerImage)
        
        shippingFeeStackView.setKeyValue("배송비", state.shipFeetext, .deliveryPrice)
        
        cardDiscountStackView.setKeyValue("카드할인", state.carddiscountText, .cardSale)
        cardDiscountStackView.addToolTip()
        
    }
}
