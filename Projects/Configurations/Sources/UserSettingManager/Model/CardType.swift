//
//  CardType.swift
//  CokeZet-Configurations
//
//  Created by 김진우 on 5/1/25.
//

import UIKit
import CokeZet_DesignSystem

public enum CardType: Int, CaseIterable {
    case nh = 1
    case kb = 2
    case sh = 3
    case lt = 4
    case hn = 5
    case ss = 6
    case hd = 7
    case wr = 8
    case ct = 9
    case bc = 10
    
    public var name: String {
        switch self {
        case .nh: return "농협"
        case .kb: return "국민"
        case .sh: return "신한"
        case .lt: return "롯데"
        case .hn: return "하나"
        case .ss: return "삼성"
        case .hd: return "현대"
        case .wr: return "우리"
        case .ct: return "씨티"
        case .bc: return "BC"
        }
    }
    
    public var image: UIImage {
        switch self {
        case .nh:
            return CokeZetDesignSystemAsset.icNh.image.withRenderingMode(.alwaysOriginal)
        case .kb:
            return CokeZetDesignSystemAsset.icKb.image.withRenderingMode(.alwaysOriginal)
        case .sh:
            return CokeZetDesignSystemAsset.icShinhan.image.withRenderingMode(.alwaysOriginal)
        case .lt:
            return CokeZetDesignSystemAsset.icLotteCard.image.withRenderingMode(.alwaysOriginal)
        case .hn:
            return CokeZetDesignSystemAsset.icHana.image.withRenderingMode(.alwaysOriginal)
        case .ss:
            return CokeZetDesignSystemAsset.icSamsung.image.withRenderingMode(.alwaysOriginal)
        case .hd:
            return CokeZetDesignSystemAsset.icHyundai.image.withRenderingMode(.alwaysOriginal)
        case .wr:
            return CokeZetDesignSystemAsset.icWoori.image.withRenderingMode(.alwaysOriginal)
        case .ct:
            return CokeZetDesignSystemAsset.icCity.image.withRenderingMode(.alwaysOriginal)
        case .bc:
            return CokeZetDesignSystemAsset.icBc.image.withRenderingMode(.alwaysOriginal)
        }
        
    }
}
