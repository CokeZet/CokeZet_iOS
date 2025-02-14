//
//  BadgeDiscountRateView.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 2/14/25.
//

import UIKit

import SnapKit


public enum DiscountRateType {
    /// 제트픽
    case zetPick
    /// 역대 최저가
    case lowest
    /// 대박
    case large
    /// 중박
    case middle
    /// 소박
    case small
    /// 평범
    case normal

    var text: String {
        switch self {
        case .zetPick:
            return "제트픽"
        case .lowest:
            return "역대 최저가"
        case .large:
            return "대박"
        case .middle:
            return "중박"
        case .small:
            return "소박"
        case .normal:
            return "평범"
        }
    }

    var textColor: UIColor {
        switch self {
        case .zetPick:
            return .Black
        case .lowest:
            return .Red500
        case .large:
            return UIColor(red: 235/255, green: 158/255, blue: 9/255, alpha: 1)
        case .middle:
            return UIColor(red: 19/255, green: 99/255, blue: 173/255, alpha: 1)
        case .small:
            return UIColor(red: 32/255, green: 137/255, blue: 171/255, alpha: 1)
        case .normal:
            return .Red50
        }
    }

    var typography: UIFont {
        switch self {
        case .zetPick:
            return CokeZetDesignSystemFontFamily.Suit.bold.font(size: 12)
        default:
            return Typography.T12.font
        }
    }

    var backgroundColor: UIColor? {
        switch self {
        case .zetPick:
            return nil // 그래디언트 처리가 필요해 nil 반환
        default:
            return UIColor.Red500.withAlphaComponent(0.12)
        }
    }
}

public final class BadgeDiscountRateView: UIView {

    public init() {
        super.init(frame: .zero)
        self.addConfigure()
        self.makeConstraints()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConfigure() {

    }

    private func makeConstraints() {

    }
}
