//
//  PriceComparisonView.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/6/25.
//

import UIKit

import CokeZet_DesignSystem

public final class PriceComparisonView: UIView {
    private let titleLabel: UILabel = UILabel().then {
        $0.text = "가격비교"
        $0.font = Typography.T18.font
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
