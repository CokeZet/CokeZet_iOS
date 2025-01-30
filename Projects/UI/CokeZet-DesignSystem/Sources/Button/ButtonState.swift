//
//  ButtonState.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 1/23/25.
//

import UIKit

public enum ButtonState: CaseIterable {
    case Primary
    case Pressed
    case Normal
    case Secondary
    case Disabled

    var titleColor: UIColor {
        switch self {
        case .Primary:
            return .White
        case .Pressed:
            return .White
        case .Normal:
            return .Black
        case .Secondary:
            return .White
        case .Disabled:
            return .Gray500
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .Primary:
            return .Red600
        case .Pressed:
            return .Red700
        case .Normal:
            return .Red50
        case .Secondary:
            return .Gray500
        case .Disabled:
            return .Gray700
        }
    }
}
