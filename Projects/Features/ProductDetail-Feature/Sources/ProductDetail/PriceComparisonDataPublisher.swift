//
//  PriceComparisonDataPublisher.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/20/25.
//

import CokeZet_DesignSystem
import CokeZet_Components

struct PriceComparisonDataPublisher {
    static var state = ProductDetailViewController.State(
        ProductImageCellData: .init(cokeImage: CokeZetDesignSystemAsset.icCanPepsi190.image, badgeType: .zetPick),
        ProductOverCellData:
                .init(
                    infomationState: ProductInfomationView.State(priceText: "13000",
                                                                 permlPrice: "193",
                                                                 sellerImage: CokeZetDesignSystemAsset.icKb.image,
                                                                 shipFeetext: "3000",
                                                                 carddiscountText: "신한카드 12300"),
                    adBannerState: AdBannerButton.State(descriptText: "신한카드, 국민카드가 있다면 이 가격에 구입 가능해요!",
                                                        priceText: "11800".formatWithComma() + "원"),
                    buyButtonAction: {
                        print("Buy 버튼 클릭 클릭")
                    },
                    adBannerButtonAction: {
                        print("Banner 버튼 클릭 클릭")
                    }
                ),
        GraphViewData:
            [
                .init(price: 13000, date: "23.11.07"),
                .init(price: 11500, date: "23.11.12"),
                .init(price: 11000, date: "23.11.28")
            ],
        PriceComparisonCellData:
            PriceComparisonCell.State(cellData:
                                        [
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
                                        })
        ,
        ProductInfomationCellData: .init(foodType: "음료", packType: "캔류", capacity: "190ml", quantity: "12캔", features: ["무가당", "무설탕"])
        
    )
}
