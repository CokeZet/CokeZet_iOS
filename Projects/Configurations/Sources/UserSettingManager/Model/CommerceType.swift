//
//  CommerceType.swift
//  CokeZet-Configurations
//
//  Created by 김진우 on 5/1/25.
//

import UIKit
import CokeZet_DesignSystem

public enum CommerceType: Int, CaseIterable {
    case coupang = 1
    case gmarket = 2
    case street11 = 3
    
    public var name: String {
        switch self {
            
        case .coupang: return "쿠팡"
        case .gmarket: return "G마켓"
        case .street11: return "11번가"
        }
    }
    
    public var image: UIImage {
        switch self {
        case .coupang:
            return CokeZetDesignSystemAsset.icCoupang.image.withRenderingMode(.alwaysOriginal)
        case .gmarket:
            return CokeZetDesignSystemAsset.icGmarket.image.withRenderingMode(.alwaysOriginal)
        case .street11:
            return CokeZetDesignSystemAsset.ic11st.image.withRenderingMode(.alwaysOriginal)
        }
    }
}
