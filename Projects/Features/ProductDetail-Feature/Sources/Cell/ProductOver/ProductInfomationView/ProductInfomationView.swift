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
    
    let titleStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .leading
    }
    
    let productTypeLabel: UILabel = ZetLabel(typography: .T14, textColor: ZetColor.Gray600.color).then {
        $0.text = "코카콜라 음료"
    }
    
    let titleLabel: UILabel = ZetLabel(typography: .T20, textColor: ZetColor.White.color).then {
        $0.text = "코카콜라 제로 190ml (12개)"
    }
    
    let productStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .leading
        $0.spacing = 4
    }
    
    let minimumPriceStackView = KeyValueStackView()
        .setKeyValue("최저가", "13000원")
        .setLargeValue()
    
    let pricePer100mlStackView = KeyValueStackView()
        .setKeyValue("100ml", "193원")
    
    let sellerStackView = KeyValueStackView()
        .setKeyValue("판매처", "")
        .setImage(CokeZetDesignSystemAsset.alertCircle.image)
    
    let shippingFeeStackView = KeyValueStackView()
        .setKeyValue("배송비", "3000원", .deliveryPrice)
    
    let cardDiscountStackView = KeyValueStackView()
        .setKeyValue("카드할인", "신한카드 12300원", .cardSale)
        .addToolTip()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLayout() {
        [titleStackView, productStackView].forEach {
            self.addSubview($0)
        }
        
        [productTypeLabel, titleLabel].forEach {
            titleStackView.addArrangedSubview($0)
        }
        
        [minimumPriceStackView, pricePer100mlStackView, sellerStackView, shippingFeeStackView, cardDiscountStackView].forEach {
            productStackView.addArrangedSubview($0)
        }
        
        titleStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        productStackView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        
    }
}
