//
//  DiscountRateType.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 2/14/25.
//

import UIKit

public enum DiscountRateType: Int, CaseIterable {
    /// 일반
    case normal
    /// 중박
    case middle
    /// 대박
    case large
    /// 역대급
    case lowest
    /// 제트픽
    case zetPick

    public var text: String {
        switch self {
        case .zetPick:
            return "제트픽"
        case .lowest:
            return "역대급"
        case .large:
            return "대박"
        case .middle:
            return "중박"
        case .normal:
            return "일반"
        }
    }

    var backgroundColor: UIColor? {
        switch self {
        case .zetPick:
            return nil
        case .lowest:
            return .Red500
        case .large:
            return UIColor(red: 235/255, green: 158/255, blue: 9/255, alpha: 1)
        case .middle:
            return UIColor(red: 19/255, green: 99/255, blue: 173/255, alpha: 1)
        case .normal:
            return .White
        }
    }

    var font: UIFont {
        switch self {
        case .zetPick:
            return Typography.extraBold(.T12).font
        default:
            return Typography.semiBold(.T12).font
        }
    }

}
