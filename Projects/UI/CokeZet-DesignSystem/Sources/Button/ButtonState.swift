//
//  ButtonState.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 1/23/25.
//

import UIKit

public enum ButtonState: CaseIterable {
    case normal
    case pressed
    case disabled

    var titleColor: UIColor {
        switch self {
        case .pressed:
            return .White
        case .normal:
            return .White
        case .disabled:
            return .Gray500
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .pressed:
            return .Red700
        case .normal:
            return .Red600
        case .disabled:
            return .Gray700
        }
    }
}
