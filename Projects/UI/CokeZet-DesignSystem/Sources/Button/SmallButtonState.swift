//
//  SmallButtonState.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 2/27/25.
//

import UIKit

public enum SmallButtonState: CaseIterable {
    case normal
    case pressed
    case disabled

    var titleColor: UIColor {
        switch self {
        case .normal:
            return .Purple600
        case .pressed:
            return .Purple600
        case .disabled:
            return .Gray800
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .normal:
            return .clear
        case .pressed:
            return .Gray700
        case .disabled:
            return .Gray700
        }
    }

    var borderColor: UIColor? {
        return .Gray600
    }
}
