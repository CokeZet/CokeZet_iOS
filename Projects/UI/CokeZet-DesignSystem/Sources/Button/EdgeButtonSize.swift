//
//  EdgeButtonSize.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 1/23/25.
//

import UIKit

public enum EdgeButtonSize: CaseIterable {
    case large
    case medium
    case small

    var height: CGFloat {
        switch self {
        case .large:
            return 64
        case .medium:
            return 48
        case .small:
            return 36
        }
    }

    var cornerRadius: CGFloat {
        switch self {
        case .large:
            return self.height / 2
        case .medium:
            return 10
        case .small:
            return 4
        }
    }
}

public enum ButtonType: CaseIterable {
    case large
    case medium
    case small

    var height: CGFloat {
        switch self {
        case .large:
            return 64
        case .medium:
            return 48
        case .small:
            return 36
        }
    }

    var cornerRadius: CGFloat {
        switch self {
        case .large:
            return self.height / 2
        case .medium:
            return 10
        case .small:
            return 4
        }
    }
}

