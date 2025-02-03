//
//  ProductOverView.swift
//  CokeZet-UI
//
//  Created by 김진우 on 1/22/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit
import Then
import CokeZet_Components
import SwiftUI

public class ProductOverCell: UICollectionViewCell {

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
    
    let buyButton = ZetRoundButton(buttonState: .Primary).then {
        $0.setTitle("최저가로 구매하기", for: .normal)
        
        let action = UIAction(handler: { _ in
            print("ProductOverView Buy Button clicked!")
        })
        
        $0.addAction(action, for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func initLayout() {
        [titleStackView, productStackView, buyButton].forEach {
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
            $0.leading.trailing.equalToSuperview()
        }
        
        buyButton.snp.makeConstraints {
            $0.top.equalTo(productStackView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

struct ProductOverCellPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> ProductOverCell {
        let cell = ProductOverCell()
        cell.backgroundColor = ZetColor.Gray800.color
        return cell
    }

    func updateUIView(_ uiView: ProductOverCell, context: Context) {}
}

@available(iOS 17.0, *)
#Preview {
    ProductOverCellPreview()
        .frame(width: 360, height: 534)
}
