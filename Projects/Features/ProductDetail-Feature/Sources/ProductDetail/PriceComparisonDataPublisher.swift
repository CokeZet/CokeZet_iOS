//
//  PriceComparisonDataPublisher.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/20/25.
//

import CokeZet_DesignSystem

struct PriceComparisonDataPublisher {
    static var cellData = [
        CokeZetDesignSystemAsset.icGmarket.image,
        CokeZetDesignSystemAsset.icCoupang.image,
        CokeZetDesignSystemAsset.ic11st.image,
        CokeZetDesignSystemAsset.icNaver.image,
        CokeZetDesignSystemAsset.icCurly.image,
    ].map {
        return PriceComparisonTableViewCell.State(image: $0,
                                                  totalPrice: "16900",
                                                  cardPrice: "신한카드 18200",
                                                  shippingFee: "3000")
    }
}
