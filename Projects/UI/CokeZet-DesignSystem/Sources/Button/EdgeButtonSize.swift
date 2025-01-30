//
//  EdgeButtonSize.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 1/23/25.
//

import UIKit

public enum EdgeButtonSize: CaseIterable {
    case Default
    case L
    case M
    case S

    var width: CGFloat {
        switch self {
        case .Default:
            return 294
        case .L:
            return 183
        case .M:
            return 142
        case .S:
            return 104
        }
    }
}
