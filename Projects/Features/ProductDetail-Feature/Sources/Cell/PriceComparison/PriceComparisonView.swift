//
//  PriceComparisonView.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/6/25.
//

import UIKit

import CokeZet_DesignSystem

public final class PriceComparisonView: UIView {
    private let titleLabel: ZetLabel = ZetLabel(typography: .semiBold(.T18), textColor: .White).then {
        $0.text = "가격비교"
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
